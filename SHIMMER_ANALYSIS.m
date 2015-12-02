
%event_file = '/ukko/projects/ReKnow/data/shimmer/event_list.csv';
%shimmer_file = '/ukko/projects/ReKnow/data/shimmer/shimmer.csv';
%empatica_file = '/ukko/projects/ReKnow/data/shimmer/empatica_eda.csv';

% local over ride
event_file = '/home/jari/work/shimmer/testrun/data/event_list.csv';
shimmer_file = '/home/jari/work/shimmer/testrun/data/shimmer.csv';
empatica_file = '/home/jari/work/shimmer/testrun/data/empatica_eda.csv';

RUN_PROCESSING = true;
RUN_LEDA = true;
RUN_ANALYSIS = true;

outdir = '/tmp/eda_testing';

if RUN_PROCESSING
	if isdir(outdir), rmdir(outdir, 's'); end;
	mkdir(outdir)

	% Load data and events
	[event_times, event_list] = read_events(event_file);
	data_shimmer = read_shimmer(shimmer_file);
	data_empatica = read_e4(empatica_file);

	% Get event times and types
	start_time = event_times(1);
	stop_time = event_times(end);
	event_times = event_times(2:end - 1);
	event_list = event_list(2:end - 1);

	% Trim datasets
	data_empatica = trim_eda(data_empatica, start_time, stop_time);
	data_shimmer = trim_eda(data_shimmer, start_time, stop_time);

	% Save data in Ledalab format
	datasets = {};
	hdr = {};

	data = generate_eda_dataset(data_empatica, event_times, event_list);
	save(fullfile(outdir, 'empatica.mat'), 'data');
	datasets{end + 1} = data;
	hdr{end + 1} = 'empatica';

	data = generate_eda_dataset(data_shimmer, event_times, event_list);
	save(fullfile(outdir, 'shimmer.mat'), 'data');
	datasets{end + 1} = data;
	hdr{end + 1} = 'shimmer';

	plot_raw(datasets, hdr);
end

% Run LEDALAB
if RUN_LEDA
	run_ledalab(outdir, 'mat');
end

% Analyze and plot results
if RUN_ANALYSIS
	analyze_shimmer(outdir);
end
