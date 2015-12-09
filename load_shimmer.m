% Reads all columns of a shimmer CSV-file, use read_shimmer for EDA only!
function [data, hdr, units] = read_shimmer(filename)

	% Read header
	fid = fopen(filename, 'r');
	fgetl(fid);
	hdr = fgetl(fid);
	units = fgetl(fid);
	fclose(fid);
	hdr = regexp(hdr, '\t', 'split');
	units = regexp(units, '\t', 'split');

	% Read data
	data = dlmread(filename, '\t', 3);
end
