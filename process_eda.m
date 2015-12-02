% Main processing function for 2R4P recordings (2015)
% 
% Jari Torniainen
% Brain Work Research Centre. Finnish Institute of Occupational Health
% 2015
% MIT License

% process_eda(indir, outdir, run_leda)
%
% Args:
% 		indir = input directory
%		outdir = output directory
%		plot_data = boolean flag for plotting raw data

function process_eda(indir, outdir, plot_data)

	files = dir(fullfile(indir, '*.csv'));

	% Find events-file and remove it from the file list -> other files are EDA
	events_file_idx = find(strcmp({files.name}, 'events.csv'));

	datasets = {};
	hdr = {};

	% Read event list
	if ~isempty(events_file_idx)
		events_file = fullfile(indir, files(events_file_idx).name);
		[event_times, event_list] = read_events(events_file);
		start_time = event_times(1);
		stop_time = event_times(end);
		event_times = event_times(2:end - 1);
		event_list = event_list(2:end - 1);

		files(events_file_idx) = [];
	else
		error('No events file found! Terminating...')
	end

	for k = 1:length(files)
		data = read_e4_eda(fullfile(indir, files(k).name));
		data = trim_eda(data, start_time, stop_time);
		data = generate_eda_dataset(data, event_times, event_list);

		[~, filename] = fileparts(files(k).name);
		save(fullfile(outdir, [filename '.mat']), 'data');

		datasets{end + 1} = data;
		hdr{end + 1} = filename;

		fprintf(1, '[OK] %s\n', filename)
	end

	if plot_data
		plot_raw(datasets, hdr);
	end
end
