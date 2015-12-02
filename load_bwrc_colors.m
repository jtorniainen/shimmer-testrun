% load_bwrc_colors - Returns a color palette containing the official BWRC colors
% 
% Jari Torniainen
% Brain Work Research Centre. Finnish Institute of Occupational Health
% 2015
% MIT License

% load_bwrc_colors()
%
% Returns:
% 		palette = palette containing the official BWRC colors

function palette = load_bwrc_colors()

	palette.orange = [240/255 170/255 0];
	palette.lblue = [0 160/255 190/255];
	palette.dblue = [0 60/255 120/255];
	palette.dgray = [130/255 130/255 130/255];
	palette.lgray = [240/255, 240/255, 240/255];
	palette.green = [180/255, 190/255, 0/255];
	palette.red = [250/255, 65/255, 0/255];
end
