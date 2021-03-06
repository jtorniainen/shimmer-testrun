eda_1 = '/ukko/projects/ReKnow/Data/shimmer/testrun2/sub1.csv';
event_1 = '/ukko/projects/ReKnow/Data/shimmer/testrun2/events1.csv';

eda_2 = '/ukko/projects/ReKnow/Data/shimmer/testrun2/sub2.csv';
event_2 = '/ukko/projects/ReKnow/Data/shimmer/testrun2/events2.csv';

eda_3 = '/ukko/projects/ReKnow/Data/shimmer/testrun2/sub3.csv';
event_3 = '/ukko/projects/ReKnow/Data/shimmer/testrun2/events3.csv';

% You can control which part of the analysis chain are run. This is for
% skipping computationally intesive steps you've already done
%
RUN_PROCESSING = 		true; % Read/time/convert data to Ledalab format
RUN_LEDA = 				true; % Run Ledalab batch processing for all files
RUN_ANALYSIS = 			true; % Calculate results

OUTDIR = '/tmp/eda_testing_video';

if RUN_PROCESSING

	% Getting rid of old results (hope you copied them somewhere lol)
	if isdir(OUTDIR), rmdir(OUTDIR, 's'); end;

	mkdir(OUTDIR)

	% Load data and events
	data = read_shimmer(eda_1);
	[event_times, event_list] = read_events(event_1);
	data = trim_eda(data, event_times(1), event_times(end));
	event_times = event_times(2:end - 1);
	event_list = event_list(2:end - 1);
	data = generate_eda_dataset(data, event_times, event_list);
	save(fullfile(OUTDIR, 'sub1.mat'), 'data');

	% Load data and events
	data = read_shimmer(eda_2);
	[event_times, event_list] = read_events(event_2);
	data = trim_eda(data, event_times(1), event_times(end));
	event_times = event_times(2:end - 1);
	event_list = event_list(2:end - 1);
	data = generate_eda_dataset(data, event_times, event_list);
	save(fullfile(OUTDIR, 'sub2.mat'), 'data');

	% Load data and events
	data = read_shimmer(eda_3);
	[event_times, event_list] = read_events(event_3);
	data = trim_eda(data, event_times(1), event_times(end));
	event_times = event_times(2:end - 1);
	event_list = event_list(2:end - 1);
	data = generate_eda_dataset(data, event_times, event_list);
	save(fullfile(OUTDIR, 'sub3.mat'), 'data');
end

% Run LEDALAB
if RUN_LEDA
	Ledalab(OUTDIR, ...
			'open', 'mat', ...
			'analyze', 'CDA', ...
			'optimize', 3, ...
			'export_scrlist', [.01 1], ...
			'export_era', [0 120 .01 1], ...
			'overview', 1);
end

% Analyze and plot results
if RUN_ANALYSIS
	analyze_shimmer(OUTDIR);
end
