% read_events - reads the event list csv-file
% 
% Jari Torniainen
% Brain Work Research Centre. Finnish Institute of Occupational Health
% 2015
% MIT License

% read_events(filename)
%
% Args:
% 		filename = name of the event-file
% 		
% Returns:
% 		times = vector of time stamps for the events
% 		event_list = event labels

function [times, event_list] = read_events(filename)

	times = [];
	event_list = {};

	fid = fopen(filename, 'r');

	if fid == -1
		error('Can not open file!');
	end

	str = fgetl(fid);

	while ischar(str)
		parts = regexp(str, ',', 'split');
		time_stamp = int32(floor(86400 * (datenum(parts{1}) - ... 
		                   datenum('01-Jan-1970'))));
		event = parts{2};

		times(end + 1) = time_stamp;
		event_list{end + 1} = event;
		str = fgetl(fid);
	end
	fclose(fid);
end
