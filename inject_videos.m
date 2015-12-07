% Injects time-stamps of different video segments into the event log
function inject_videos(outputfile, logfile, offsetfile)
	% Read offsets
	fid = fopen(offsetfile, 'r');
	if fid == -1, error('Could not open offset-file!'); end;

	offset = [];
	segment_name = {};

	str = fgetl(fid);
	while ischar(str)
		contents = regexp(str, ',', 'split');
		offset(end + 1) = str2double(contents{1});
		segment_name{end + 1} = contents{2};
		str = fgetl(fid);
	end
	fclose(fid);

	% Read log and add offsets
	[event_times, event_names] = read_events(logfile);

	fid = fopen(outputfile, 'w');
	if fid == -1, error('Could not open output-file1'); end;

	fprintf(fid, '%s,%s\n', datestr(u2d(event_times(1))), event_names{1});

	for k = 1:length(offset)
		fprintf(fid, '%s,%s\n', ...
			    datestr(u2d(event_times(1) + offset(k))), segment_name{k});
	end

	fprintf(fid, '%s,%s\n', datestr(u2d(event_times(end))), event_names{end});

	fclose(fid);
end
