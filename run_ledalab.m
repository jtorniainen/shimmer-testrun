% run_ledalab - handler function for Ledalab batch analysis
% 
% Jari Torniainen
% Brain Work Research Centre. Finnish Institute of Occupational Health
% 2015
% MIT License

% run_ledalab(indir)
%
% Args:
% 		indir = input directory for Ledalab batch-mode

function run_ledalab(indir, filetype)

	Ledalab(indir, ...
			'open', filetype, ... 
			'analyze', 'CDA', ...
			'optimize', 3, ... 
			'export_scrlist', [.25 1], ... 
			'export_era', [0 420 .25 1], ...
			'overview', 1);
end
