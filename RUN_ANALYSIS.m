% This is a top-level script for running the whole analysis pipe
run1_indir = '/ukko/projects/ReKnow/Data/2r4p_eda/run1_clean';
run2_indir = '/ukko/projects/ReKnow/Data/2r4p_eda/run2_clean';

run1_outdir = '/ukko/projects/ReKnow/Data/2r4p_eda/analysis1_clean';
run2_outdir = '/ukko/projects/ReKnow/Data/2r4p_eda/analysis2_clean';

era_results1 = fullfile(run1_outdir, 'era1.csv');
era_results2 = fullfile(run2_outdir, 'era2.csv');

% Analysis options
RUN_PREPROCESSING = false;  			% This will turn off all preprocessing
RUN_LEDA = false; 						% Turns off Ledalab
RUN_RESULTS = true; 					% Turns off result analysis

BIN_COUNT = 16; % How many bins used for the peak number analysis

if RUN_PREPROCESSING
	if isdir(run1_outdir), rmdir(run1_outdir, 's'); end;
	if isdir(run2_outdir), rmdir(run2_outdir, 's'); end;
		
	mkdir(run1_outdir);
	mkdir(run2_outdir);

	process_eda(run1_indir, run1_outdir, false);
	process_eda(run2_indir, run2_outdir, false);
end

if RUN_LEDA
	run_ledalab(run1_outdir);
	run_ledalab(run2_outdir);
end

if RUN_RESULTS
	analyze_eda(run1_outdir, BIN_COUNT, era_results1);
	analyze_eda(run2_outdir, BIN_COUNT, era_results2);

	hdr = read_hdr(era_results1);
	data1 = csvread(era_results1, 1);
	data2 = csvread(era_results2, 1);

	plot_era(cat(1, data1, data2), hdr);
end
