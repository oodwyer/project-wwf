function Masterscript
%First script to start the game 
close all

figure 
a = annotation('textbox','position',[.1 .8 .8 .2],'String','Welcome to Words with Friends!','backgroundColor','w');
sz = a.FontSize;
a.FontSize = 24;
a.HorizontalAlignment = 'center';
a.VerticalAlignment = 'middle';

uicontrol('Style','Pushbutton','Units','Normalized','Position',[0.1 0.5 .8 .2],'String','Start Game!', 'FontSize',24,'CallBack',@MainBoard)
%after start game, add the callback function for when button is pushed 


end

