function plot_phasic(drivers, time, event, hdr)
	bwrc = load_bwrc_colors();

	scaling = 2;
	hold on;
		for k = 1:size(drivers, 1)
			plot(time, drivers(k, :) + (k * scaling), '-', 'color', bwrc.lblue);
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
		text(-500, scaling * k, hdr{k}, 'backgroundcolor', 'w');
	end

	box on;
	xlabel('t [s]');
	grid on;
	grid minor;
	box on;
	title('Phasic activity');
end
