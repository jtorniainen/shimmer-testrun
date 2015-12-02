% get_phasic_train - Returns a binary signal representing the phasic driver
% 
% Jari Torniainen
% Brain Work Research Centre. Finnish Institute of Occupational Health
% 2015
% MIT License

% get_phasic_train(time, scrlist)
%
% Args:
% 		time = time stamps
% 		scrlist = list of SCR amplitudes
%
% Returns:
% 		driver = binary driver signal representing the phasic driver

function driver =  get_phasic_train(time, scrlist)
	driver = zeros(size(time));
	use_amplitudes = false;
	for k = 1:length(scrlist.CDA.onset)
		[~, idx] = min(abs(time - scrlist.CDA.onset(k)));
		if use_amplitudes
			driver(idx) = driver(idx) + scrlist.CDA.amp(k);
		else
			driver(idx) = driver(idx) + 1;
		end
	end
end	
