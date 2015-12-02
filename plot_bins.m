function plot_bins(drivers, time, event, hdr)

	bwrc = load_bwrc_colors();
	colors = {bwrc.lblue, bwrc.orange, bwrc.dblue, bwrc.dgray, bwrc.red, bwrc.green};

	imagesc(time, 1:size(drivers, 1), drivers);
	hold on;
		ylims = get(gca, 'ylim');
		for k = 1:length(event)
			line([event(k).time, event(k).time], ylims, 'color', 'r');
		end
	hold off;
	%colormap summer
	ax = gca();
	ax.YTick = 1:length(hdr);
	ax.YTickLabel = hdr;
	colorbar('location', 'southoutside');
	title('Number of Significant SCRs');
	xlabel('t[s]');

end
