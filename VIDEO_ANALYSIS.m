eda_1 = '/ukko/projects/ReKnow/data/shimmer/testrun2/sub1.csv';
event_1 = '/ukko/projects/ReKnow/data/shimmer/testrun2/events1.csv';

eda_2 = '/ukko/projects/ReKnow/data/shimmer/testrun2/sub2.csv';
event_2 = '/ukko/projects/ReKnow/data/shimmer/testrun2/events2.csv';

eda_3 = '/ukko/projects/ReKnow/data/shimmer/testrun2/sub3.csv';
event_3 = '/ukko/projects/ReKnow/data/shimmer/testrun2/events3.csv';

% You can control which part of the analysis chain are run. This is for
% skipping computationally intesive steps you've already done
%
RUN_PROCESSING = 		true; % Read/time/convert data to Ledalab format
RUN_LEDA = 				true; % Run Ledalab batch processing for all files
RUN_ANALYSIS = 			true; % Calculate results

outdir = '/tmp/eda_testing';

if RUN_PROCESSING

	% Getting rid of old results (hope you copied them somewhere lol)
	if isdir(outdir), rmdir(outdir, 's'); end;

	mkdir(outdir)

	% Load data and events
	data1 = read_shimmer(eda_1);
	[et1, el1] = read_events(event_1);
	data1 = trim_eda(data1, et1(1), et1(end));

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

end

% Run LEDALAB
if RUN_LEDA
	run_ledalab(outdir, 'mat');
end

% Analyze and plot results
if RUN_ANALYSIS
	analyze_shimmer(outdir);
end
