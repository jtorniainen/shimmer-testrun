function data = generate_eda_dataset(eda, event_times, event_list)
	conductance = eda(:, 2);
	time = eda(:, 1);
	data.conductance = conductance;
	data.time = time;

	data.event = struct('name', [], 'time', [], 'nid', []);
	for k = 1:length(event_list)
		data.event(k).name = event_list{k};
		data.event(k).time = event_times(k);
		data.event(k).nid = k;
	end
end
