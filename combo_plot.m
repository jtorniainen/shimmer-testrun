% combo_plot - utility to function to create a montage result plot.
% 
% Jari Torniainen
% Brain Work Research Centre. Finnish Institute of Occupational Health
% 2015
% MIT License

% combo_plot(datasets, hdr, event, drivers, driver_time, bins, bin_time)
%
% Args:
% 		datasets = cell array of Ledalab-datasets
% 		hdr = cell array of headers
% 		drivers = matrix of SCR drivers
% 		driver_time = time vector for the SCR driver matrix
% 		bins = binned nSCR matrix
% 		bin_tme = time vector for binned nSCR matrix
%
function combo_plot(datasets, hdr, event, drivers, driver_time, bins, bin_time)

	figure();

	subplot(2, 3, 1:2);
		plot_raw(datasets, hdr);

	subplot(2, 3, 4:5);
		plot_phasic(drivers, driver_time, event, hdr);

	subplot(2, 3, 3);
		plot_bins(bins, bin_time, event, hdr)

	subplot(2, 3, 6);
		plot_cumulative(bins, bin_time, event, hdr)

end
