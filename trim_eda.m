% trim_eda - summary of the function
% 
% Jari Torniainen
% Brain Work Research Centre. Finnish Institute of Occupational Health
% 2015
% MIT License

% trim_eda(data, start_time, stop_time)
%
% Args:
% 		data = EDA data matrix ([time data])
% 		start_time = starting timestamp (e.g. 08-Oct-2015 06:11:55)
% 		stop_time = stopping timestamp (e.g. 08-Oct-2015 06:11:55)

function data = trim_eda(data, start_time, stop_time)
	time = data(:, 1);

	[~, idx_start] = min(abs(time - double(start_time)));
	[~, idx_stop] = min(abs(time - double(stop_time)));

	data = data(idx_start:idx_stop, :);
end
