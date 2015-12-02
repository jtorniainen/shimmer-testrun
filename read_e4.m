% read_e4 - 	reads the e4 csv-file and returns a matrix containing the time
% 				vector and the EDA data.
% 
% Jari Torniainen
% Brain Work Research Centre. Finnish Institute of Occupational Health
% 2015
% MIT License

% read_e4(filename)
%
% Args:
% 		filename = path to the E4 csv-file
%
% Returns:
% 		data = Nx2 matrix containing time and data vectors

function data = read_e4(filename)

	data = dlmread(filename);

	start_time = data(1);  % Initial time stamp
	fs = data(2);  % Sampling rate
	data = data(3:end);  % Actual data

	time = start_time:1/fs:start_time + (length(data)-1) * 1/fs;
	time = time';

	data = [time, data];

end
