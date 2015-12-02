function plot_era(data, hdr)
	% There are 7 features to plot!
	% Should we maybe skip tonic to make a nice 3x2 plot?
	%
	% TODO: Get rid of hardcoded numeric values

	bwrc = load_bwrc_colors()

	figure();

	for k = 4:size(data, 2)
		[baseline_mean, baseline_std] = get_stats(data(data(:, 3) == 1, k));
		[coding_mean, coding_std] = get_stats(data(data(:, 3) == 2, k));
		[guiding_mean, guiding_std] = get_stats(data(data(:, 3) == 3, k));
		subplot(1, 7, k - 3);
		hold on;

		plot(1, baseline_mean, 'wo', 'markerfacecolor', bwrc.orange, 'markersize', 10, 'markeredgecolor', bwrc.dgray);
		plot(2, coding_mean, 'wo', 'markerfacecolor', bwrc.lblue, 'markersize', 10, 'markeredgecolor', bwrc.dgray);
		plot(3, guiding_mean, 'wo', 'markerfacecolor', bwrc.dblue, 'markersize', 10, 'markeredgecolor', bwrc.dgray);

		line([1, 1], [baseline_mean - baseline_std, baseline_mean + baseline_std]);
		line([2, 2], [coding_mean - coding_std, coding_mean + coding_std]);
		line([3, 3], [guiding_mean - guiding_std, guiding_mean + guiding_std]);
		box on;

		set(gca, 'xlim', [0, 4], 'xtick', []);

		title(hdr{k});

		hold off

		if k == size(data, 2)
			legend({'Baseline', 'Coding', 'Guiding'});
		end

	end
end


function [u, s] = get_stats(vector)
	u = nanmean(vector);
	s = nanstd(vector);
end
