% aggregate_events - This function aggregates all seven CDA features from all
% 					 the files it finds in the input directory. Results are
% 					 divided into three different conditions (baseline, coding
% 					 and guiding). Function returns the results in a matrix
% 					 together with a header.
% 
% Jari Torniainen
% Brain Work Research Centre. Finnish Institute of Occupational Health
% 2015
% MIT License

% aggregate_events(indir)
%
% Args:
% 		indir = input directory containing the analysis results
%
% Returns:
% 		data = matrix of EDA features
% 		hdr = header explaining the contents of data

function [data, hdr] = aggregate_events(indir)

	identifiers = file_filter(indir);
	% TODO: Copy files-exist check from analyze_eda
	hdr = {'pair_id', 'pair_number', 'condition', 'nSCR', 'Latency', ... 
		   'AmpSum', 'SCR', 'ISCR', 'PhasicMax', 'Tonic'};

	data = [];
	for k = 1:length(identifiers)
		if pair_exists(indir, identifiers(k))
			pair1 = load(fullfile(indir, ...
								  sprintf('%02da_era.mat', identifiers(k))));

			new_data = get_data(identifiers(k), 1, pair1.results);
			data = cat(1, data, new_data);

			pair2 = load(fullfile(indir, ... 
								  sprintf('%02db_era.mat', identifiers(k))));

			new_data = get_data(identifiers(k), 2, pair2.results);
			data = cat(1, data, new_data);
		end
	end
end


function data = get_data(pair_id, pair_number, results)

	% Condition vector values:
	% 		1 = Baseline		(x1)
	% 		2 = Coding			(x4)
	% 		3 = Guiding			(x4)

	% Generate vectors for pair ID and pair number
	pair_id_vector = repmat(pair_id, 9, 1);
	pair_number_vector = repmat(pair_number, 9, 1);

	% Generate condition vector
	BASELINE = 1;
	CODING = 2;
	GUIDING = 3;

	condition_vector = ones(8, 1);
	if mod(pair_number, 2) == 0
		condition_vector(1:2:end) = GUIDING;
		condition_vector(2:2:end) = CODING;
	else
		condition_vector(1:2:end) = CODING;
		condition_vector(2:2:end) = GUIDING;
	end

	condition_vector = cat(1, BASELINE, condition_vector);

	% Extract EDA-CDA features
	data = [results.CDA.nSCR', ...
			results.CDA.Latency', ...
			results.CDA.AmpSum', ...
			results.CDA.SCR', ...
			results.CDA.ISCR', ...
			results.CDA.PhasicMax', ...
			results.CDA.Tonic'];

	% Compile everything to a single matrix
	data = cat(2, pair_id_vector, pair_number_vector, condition_vector, data);
end
