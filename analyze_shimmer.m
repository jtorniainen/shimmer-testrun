% analyze_shimmer - main analysis function for 2R4P recordings (2015)
% 
% Jari Torniainen
% Brain Work Research Centre. Finnish Institute of Occupational Health
% 2015
% MIT License

% analyze_shimmer(indir, bins, filename)
%
% Args:
% 		indir = input directory
%		bins = number of bins to use in the analysis
%		filename = path to the output file

function analyze_shimmer(indir)

	hdr = {};
	phasic_data = {};
	phasic_time = {};

	datasets = {};
	use_amps = false;

	load(fullfile(indir, 'empatica.mat'));
	load(fullfile(indir, 'empatica_scrlist.mat'));
	hdr{end + 1} = 'empatica';

	datasets{end + 1} = data;
	phasic_data{end + 1} = analysis.phasicData;
	phasic_time{end + 1}  = data.time;

	event = data.event;

	clear data;
	clear analysis;
	clear scrList;

	load(fullfile(indir, 'shimmer.mat'));
	load(fullfile(indir, 'shimmer_scrlist.mat'));
	hdr{end + 1} = 'shimmer';

	datasets{end + 1} = data;
	phasic_data{end + 1} = analysis.phasicData;
	phasic_time{end + 1}  = data.time;

	plot_shimmer(phasic_time, phasic_data, datasets, event, hdr);

end
