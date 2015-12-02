% file_filter - Utility function that returns file identifiers 
% 			    (01, 02, 03 ..etc) from the specified directory.
% 
% Jari Torniainen
% Brain Work Research Centre. Finnish Institute of Occupational Health
% 2015
% MIT License

% file_filter(indir)
%
% Args:
% 		indir = input directory of .mat files
%
% Returns:
% 		identifiers = vector of unique identifiers found in the directory

function identifiers =  file_filter(indir)
	files = dir(fullfile(indir, '*.mat'));

	all_files = regexp({files.name}, '\d{2}', 'match');
	idx = find(~cellfun(@isempty, all_files));
	all_files = all_files(idx);

	identifiers = unique(cellfun(@str2double, all_files));
end
