% Reads the shimmer csv file and returns timestamps (unix seconds) with the EDA
% data. This might only work for the test file (depeding on the fileformat)
function data = read_shimmer(filename)

	% Read header
	fid = fopen(filename, 'r');
	fgetl(fid);
	hdr = fgetl(fid);
	fclose(fid);
	hdr = regexp(hdr, '\t', 'split');

	% Read data
	idx = 6;
	fprintf(1, 'Reading data from column %d (%s)', idx, hdr{idx});
	data = dlmread(filename, '\t', 3);
	time = data(:, 1) / 1e3;
	eda = (1 ./ (data(:, idx) * 1e3)) * 1e6;  % Converting kOhms to uS
	data = [time, eda];
end
