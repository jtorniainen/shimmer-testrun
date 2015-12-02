function plot_shimmer(phasic_time, phasic_data, datasets, event, hdr)

	bwrc = load_bwrc_colors();

	figure();
	subplot(2, 1, 1);
	plot_raw(datasets, hdr)

	subplot(2, 1, 2);
	scaling = 1;
	hold on;
		for k = 1:length(phasic_data)
			plot(phasic_time{k}, phasic_data{k} + (k * scaling), '-', ...
				 'color', bwrc.lblue);
		end

		axis tight;
		ylims = get(gca, 'ylim');
		set(gca, 'ylim', [0 ylims(2)]);
		ylims = get(gca, 'ylim');
		for k = 1:length(event)
			line([event(k).time, event(k).time], ylims, 'color', bwrc.dgray);
			text(event(k).time, mean(ylims), event(k).name, ...
				 'backgroundcolor', 'w', 'rotation', 90, 'fontsize', 8);
		end
	hold off;
	set(gca, 'ytick', []);

	for k = 1:length(hdr)
		text(-200, scaling * k, hdr{k}, 'backgroundcolor', 'w');
	end

	box on;
	xlabel('t [s]');
	grid on;
	grid minor;
	box on;
	title('Phasic activity');
end
