function plot_bins(drivers, time, event, hdr)
	% Cumulative sum
	bwrc = load_bwrc_colors();
	colors = {bwrc.lblue, bwrc.orange, bwrc.dblue, bwrc.dgray, bwrc.red, bwrc.green};

	hold on;
	for k = 1:size(drivers, 1)
		plot(time, cumsum(drivers(k, :)), '-', 'color', colors{k});
	end
	ylims = get(gca, 'ylim');
	for k = 1:length(event)
		line([event(k).time, event(k).time], ylims, 'color', bwrc.dgray);
		text(event(k).time, 50, event(k).name, ...
			 'backgroundcolor', 'w', 'rotation', 90, 'fontsize', 8);
	end
	hold off;
	axis tight;
	legend(hdr, 'location', 'northwest');
	title('Cumulative Number of Significant SCRs');
	ylabel('N');
	xlabel('t[s]');
	box on;
	grid on;
end

