% My universal header reader
function hdr = read_hdr(filename, varargin)

	if length(varargin) == 1
		delim = varargin{1}
	else
		delim = ',';
	end

	fid = fopen(filename, 'r');
	if fid == -1
		error('Could not open file!');
	end

	str = fgetl(fid);
	hdr = regexp(str, delim, 'split');

	fclose(fid);
end
