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

	load(fullfile(indir, 'sub1.mat'));
	load(fullfile(indir, 'sub1_scrlist.mat'));
	hdr{end + 1} = 'subject 1';

	datasets{end + 1} = data;
	phasic_data{end + 1} = analysis.phasicData./max(analysis.phasicData);
	phasic_time{end + 1}  = data.time;

	event = data.event;

	clear data;
	clear analysis;
	clear scrList;

	load(fullfile(indir, 'sub2.mat'));
	load(fullfile(indir, 'sub2_scrlist.mat'));
	hdr{end + 1} = 'subject 2';

	datasets{end + 1} = data;
	phasic_data{end + 1} = analysis.phasicData./max(analysis.phasicData);
	phasic_time{end + 1}  = data.time;

	event = data.event;

	clear data;
	clear analysis;
	clear scrList;

	load(fullfile(indir, 'sub3.mat'));
	load(fullfile(indir, 'sub3_scrlist.mat'));
	hdr{end + 1} = 'subject 3';

	datasets{end + 1} = data;
	phasic_data{end + 1} = analysis.phasicData./max(analysis.phasicData);
	phasic_time{end + 1}  = data.time;

	event = data.event;

	clear data;
	clear analysis;
	clear scrList;

	plot_shimmer(phasic_time, phasic_data, datasets, event, hdr);

end
