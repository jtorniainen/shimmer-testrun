% pair_exists - returns 'true' if both files of the pair recording can be found
% 				in the input directory.
%
% Jari Torniainen
% Brain Work Research Centre. Finnish Institute of Occupational Health
% 2015
% MIT License

% pair_exists(path, id)
%
% Args:
% 		path = path to the file
% 		id = identification number of the recording
%
% Returns:
% 		return_value = true or false depending if both files of the pair were
% 					   found

function return_value = pair_exists(path, id)
	pair_a = sprintf('%0.2da', id);
	pair_b = sprintf('%0.2db', id);

	pair_a_ok = exist(fullfile(path, [pair_a '.mat'])) == 2 && ...
					  exist(fullfile(path, [pair_a '_scrlist.mat'])) == 2;

	pair_b_ok = exist(fullfile(path, [pair_b '.mat'])) == 2 && ...
					  exist(fullfile(path, [pair_b '_scrlist.mat'])) == 2;

	if pair_a_ok && pair_b_ok
		return_value = true;
	else
		return_value = false;
	end

end
