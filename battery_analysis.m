function battery_analysis(filename, bat_idx)
	[data, hdr, units] = load_shimmer(filename);

	bat_level = data(:, bat_idx);
	time = (data(:, 1)/1e3);
	

	bat_level = smooth(bat_level, 100) ./ 1e3;
	time = linspace(0, time(end) - time(1), length(bat_level)) / (60 * 60);

	figure();
	hold on;
	plot(time, bat_level, 'k');
	axis tight;

	ylabel('Voltage [V]');
	xlabel('Time [h]');
	title('Shimmer battery');
	grid on;
	box on;

	add_note('100%', 4.167, bat_level, time);
	add_note('96.4%', 4.113, bat_level, time);
	hold off;

end


function add_note(str, target, signal, time)
	[~, idx] = min(abs(signal - target));
	text(time(idx) + .2, signal(idx), str, 'backgroundcolor', 'w');
	plot(time(idx), signal(idx), 'ko', 'markerfacecolor', 'g');
end
