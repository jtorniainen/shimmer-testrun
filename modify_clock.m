% modify_clock.m - Modifies the starting timestamp of an E4 recording
%
% Jari Torniainen 
% Brain Work Research Centre, Finnish Institute of Occupational Health 2015
%
% MIT License

function modify_clock(filename, modifier)
	data = dlmread(filename);
	data(1) = data(1) + modifier;
	dlmwrite(filename, data, 'precision', '%0.6f');
end
