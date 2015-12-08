DATADIR = '/ukko/scratch/jari/2015-12-04T142754/';
SESSIONS = [1, 2, 3];
OUTDIR = '/tmp/neurone_analysis/';
EVENTS = '/home/jari/work/shimmer/testrun2/video_offsets.csv';

% You can control which part of the analysis chain are run. This is for
% skipping computationally intesive steps you've already done
%
RUN_PROCESSING = 		true; % Read/time/convert data to Ledalab format
RUN_LEDA = 				true; % Run Ledalab batch processing for all files
RUN_ANALYSIS = 			true; % Calculate results


if RUN_PROCESSING
	if isdir(OUTDIR), rmdir(OUTDIR, 's'); end;

	mkdir(OUTDIR)

	read_neurone(DATADIR, OUTDIR, SESSIONS, EVENTS);
end

% Run LEDALAB
if RUN_LEDA
	Ledalab(OUTDIR, ...
			'open', 'mat', ... 
			'analyze', 'CDA', ...
			'optimize', 3, ... 
			'downsample', 10, ...
			'export_scrlist', [.01 1], ... 
			'export_era', [0 120 .01 1], ...
			'overview', 1);
end

% Analyze and plot results
if RUN_ANALYSIS
	analyze_shimmer(OUTDIR);
end
