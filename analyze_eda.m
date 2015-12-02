% analyze_eda - main analysis function for 2R4P recordings (2015)
% 
% Jari Torniainen
% Brain Work Research Centre. Finnish Institute of Occupational Health
% 2015
% MIT License

% analyze_eda(indir, bins, filename)
%
% Args:
% 		indir = input directory
%		bins = number of bins to use in the analysis
%		filename = path to the output file

function analyze_eda(indir, bins, filename)

	hdr = {};
	drivers = [];
	phasic = [];
	datasets = {};
	use_amps = false;

	% Find all file identifiers
	identifiers = file_filter(indir);

	for k = 1:length(identifiers)
		% Check that both files exist
		if pair_exists(indir, identifiers(k))
			load(fullfile(indir, sprintf('%0.2da.mat', identifiers(k))));
			load(fullfile(indir, sprintf('%0.2da_scrlist.mat', identifiers(k))));
			hdr{end + 1} = sprintf('%0.2da', identifiers(k));
			time = linspace(data.time(1), data.time(end), bins);
			drivers = cat(1, drivers, get_phasic_train(time, scrList));
			phasic = cat(1, phasic, analysis.phasicData);
			phasic_time = data.time;
			event = data.event;
			datasets{end + 1} = data;

			clear data;
			clear analysis;
			clear scrList;

			load(fullfile(indir, sprintf('%0.2db.mat', identifiers(k))));
			load(fullfile(indir, sprintf('%0.2db_scrlist.mat', identifiers(k))));
			hdr{end + 1} = sprintf('%0.2db', identifiers(k));
			time = linspace(data.time(1), data.time(end), bins);
			drivers = cat(1, drivers, get_phasic_train(time, scrList));
			phasic = cat(1, phasic, analysis.phasicData);
			phasic_time = data.time;
			event = data.event;
			datasets{end + 1} = data;
		else
			fprintf(1, 'Files for %0.2d not found!\n', identifiers(k));
		end
	end

	combo_plot(datasets, hdr, event,  phasic, phasic_time, drivers, time);

	[data, hdr] = aggregate_events(indir);
	csvwrite_with_headers(filename, data, hdr);
end
