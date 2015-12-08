% Read neurone files into more sane fileformat
function read_neurone(indir, outdir, sessions, eventfile)

	max_length = 544;

	fid = fopen(eventfile, 'r');
	if fid == -1, error('Could not open event file!'); end;

	event_times = [];
	event_labels = {};

	str = fgetl(fid);
	while ischar(str)
		contents = regexp(str, ',', 'split');
		event_times(end + 1) = str2double(contents{1});
		event_labels{end + 1} = contents{2};
		str = fgetl(fid);
	end
	fclose(fid);

	for k = 1:length(sessions)
		data = module_read_neurone(indir, 'sessionPhaseNumber', sessions(k));
		conductance = convert_to_siemens(data.signal.EDA.data);
		fs = data.signal.EDA.samplingRate;
		conductance = conductance(1:fs*max_length);
		conductance = medfilt1(conductance, 100);  % Remove spike artifacts
		% Need burn-offs because of transients (removing 1s)
		conductance = conductance(fs:end);
		event_times = event_times - 1;
		conductance = conductance + abs(min(conductance));
		time = linspace(0, length(conductance)/fs, length(conductance))';
		eda = [time, conductance];

		data = generate_eda_dataset(eda, event_times, event_labels);
		save(fullfile(outdir, sprintf('sub%d.mat', k)), 'data');
	end

end

% Converts the registered to voltage to µS
function conductance = convert_to_siemens(voltage)
	adapter_constant = .1;  % This is just a guess for now
	conductance = 24*((1/adapter_constant)*(voltage / 1e6)) - 49.2;
end
