function plot_raw(datasets, hdr)

	if isstruct(datasets)
		datasets = {datasets};
	end

	bwrc = load_bwrc_colors();
	colors = {bwrc.lblue, bwrc.orange, bwrc.dblue, bwrc.dgray, bwrc.red, bwrc.green};
	

	legends = {};
	hold on;
	% Plot data
	for k = 1:length(datasets)
		plot(datasets{k}.time, datasets{k}.conductance, '-', 'color', colors{k});
	end

	axis tight;
	ylims = get(gca, 'ylim');

	% Take events from the first dataset
	data = datasets{1};
	for k = 1:length(data.event)
		line([data.event(k).time, data.event(k).time], ylims, ...
			 'color', bwrc.dgray)
		text(data.event(k).time, .25 * mean(ylims), data.event(k).name, ...
		     'backgroundcolor', 'w', 'rotation', 90);
	end

	hold off;
	legend(hdr);
	box on;
	xlabel('t[s]');
	ylabel('G[uS]');
	title('Raw GSR');
end
