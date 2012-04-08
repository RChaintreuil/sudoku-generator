% -------------------------------------------------------------------------
% Projet de conception - Générateur de grilles de Sudoku
% Supélec 2011-2012
% 
% CHAINTREUIL Rémi - XIONG Yuhui
%--------------------------------------------------------------------------

%% MISE EN PLACE DE L'INTERFACE GRAPHIQUE

function main

global handles sudoku text delimiteur progressbar pourcentage

handles(1)=figure('units','pixels',...  % Fenêtre principale
    'position',[400 40 600 700],...
    'color',[0.925 0.913 0.687],...
    'numbertitle','off',...
    'name','Générateur de grille de sudoku',...
    'menubar','none',...
    'tag','interface');

handles(2)=uicontrol('style','pushbutton',...   % Bouton niveau facile
    'units','normalized',...
    'position',[0.55 0.05 0.4 0.05],...
    'string','Générer une grille de niveau facile',...    
    'callback',@grilleFacile,...
    'tag','bouton-');

handles(3)=uicontrol('style','pushbutton',...   % Bouton niveau facile
    'units','normalized',...
    'position',[0.05 0.05 0.4 0.05],...
    'string','Générer une grille de niveau difficile',...
    'callback',@grilleDifficile,...
    'tag','bouton-');


text(1)=uicontrol('style','text',...    % Texte d'accueil
        'units','normalized',...
        'position',[0 0.8 1 0.1],...
        'BackgroundColor',[0.925 0.913 0.687],...
        'string','Bienvenue sur notre générateur de grille de Sudoku !',...
        'FontSize',14); 
    
text(2)=uicontrol('style','text',...    % Texte
        'units','normalized',...
        'position',[0.1 0.7 0.8 0.1],...
        'BackgroundColor',[0.925 0.913 0.687],...
        'string','Ce générateur permet de générer des grilles de niveau facile ou difficile, et de tenter de les résoudre.',...
        'FontSize',12); 
    
text(3)=uicontrol('style','text',...    % Texte
        'units','normalized',...
        'position',[0.1 0.6 0.8 0.1],...
        'BackgroundColor',[0.925 0.913 0.687],...
        'string','Il se peut que la génération de grilles de niveau difficile prenne plusieurs minutes.',...
        'FontSize',12); 
    
text(4)=uicontrol('style','text',...    % Texte
        'units','normalized',...
        'position',[0 0.5 1 0.1],...
        'BackgroundColor',[0.925 0.913 0.687],...
        'string','CHAINTREUIL Rémi et XIONG Yuhui',...
        'FontSize',10); 
    
progressbar = uicontrol('style','text',...    % Texte
        'units','normalized',...
        'position',[0.1 0.45 0.00001 0.003],...
        'BackgroundColor',[0.1 0.1 0.1],...
        'string','',...
        'visible', 'off',...
        'FontSize',10);
    
pourcentage = uicontrol('style','text',...    % Texte
        'units','normalized',...
        'position',[0.45 0.38 0.1 0.05],...
        'BackgroundColor',[0.925 0.913 0.687],...
        'string','0%',...
        'visible','off',...
        'FontSize',8);

for i = 1:1:9   % Cases de la grille de Sudoku
    for j = 1:1:9
       sudoku(i,j)=uicontrol('style','edit',...
        'units','normalized',...
        'position',[-0.05+j*0.1 0.97-i*0.09 0.1 0.09],...
        'string','',...
        'visible','off',...
        'callback',{@test,i,j},...
        'FontSize',30); 
    end
end

delimiteur(1) = uicontrol('style','text',...
        'units','normalized',...
        'position',[0.05 0.7 0.91 0.005],...
        'string','',...
        'BackgroundColor',[0.1 0.1 0.1],...
        'visible','off',...
        'FontSize',30); 
    
delimiteur(2) = uicontrol('style','text',...
        'units','normalized',...
        'position',[0.05 0.43 0.91 0.005],...
        'string','',...
        'BackgroundColor',[0.1 0.1 0.1],...
        'visible','off',...
        'FontSize',30); 
    
delimiteur(3) = uicontrol('style','text',...
        'units','normalized',...
        'position',[0.345 0.16 0.005 0.82],...
        'string','',...
        'BackgroundColor',[0.1 0.1 0.1],...
        'visible','off',...
        'FontSize',30); 
    
delimiteur(4) = uicontrol('style','text',...
        'units','normalized',...
        'position',[0.645 0.16 0.005 0.82],...
        'string','',...
        'BackgroundColor',[0.1 0.1 0.1],...
        'visible','off',...
        'FontSize',30); 
    
delimiteur(5) = uicontrol('style','text',...
        'units','normalized',...
        'position',[0.04 0.97 0.92 0.01],...
        'string','',...
        'BackgroundColor',[0.1 0.1 0.1],...
        'visible','off',...
        'FontSize',30); 
    
delimiteur(6) = uicontrol('style','text',...
        'units','normalized',...
        'position',[0.04 0.15 0.01 0.82],...
        'string','',...
        'BackgroundColor',[0.1 0.1 0.1],...
        'visible','off',...
        'FontSize',30); 
    
delimiteur(7) = uicontrol('style','text',...
        'units','normalized',...
        'position',[0.95 0.15 0.01 0.82],...
        'string','',...
        'BackgroundColor',[0.1 0.1 0.1],...
        'visible','off',...
        'FontSize',30); 
    
delimiteur(8) = uicontrol('style','text',...
        'units','normalized',...
        'position',[0.04 0.15 0.92 0.01],...
        'string','',...
        'BackgroundColor',[0.1 0.1 0.1],...
        'visible','off',...
        'FontSize',30); 

%% FONCTIONS PRINCIPALES

function grilleFacile(obj, event)   % Génération d'une grille facile

global handles sudoku text GrillePleine delimiteur progressbar pourcentage

set(handles(2),'enable','off');
set(handles(3),'enable','off');

for i = 1:1:3
    set(text(i),'visible','off');   % Suppression des textes d'accueil
    drawnow
end

for i = 1:1:8
    set(delimiteur(i),'visible','off');
end

for i = 1:1:9   % Réinitialisation de la grille
    for j = 1:1:9
        set(sudoku(i,j),'string','');   
        set(sudoku(i,j),'BackgroundColor',[1 1 1]);
        set(sudoku(i,j),'enable','on');
        set(sudoku(i,j),'visible','off');
    end
end

drawnow

set(text(4),'string','Génération de la grille de niveau facile...');
set(text(4),'visible','on');
set(progressbar,'position',[0.1 0.45 0.00001 0.003]);
set(pourcentage,'string','0%');

drawnow

GrillePleine = getGrillePleine(progressbar, pourcentage);   % Synthèse d'une grille pleine


for i = 1:1:8
    set(delimiteur(i),'visible','on');
end

GrilleFacile = genGrilleFacile(GrillePleine);   % Création de la grille

for i = 1:1:9   % Mise à jour de la grille graphique
    for j = 1:1:9
        if(GrilleFacile(i,j) ~= 0)
            set(sudoku(i,j),'string',GrilleFacile(i,j));
            set(sudoku(i,j),'BackgroundColor',[0.9 0.9 0.9]);
            set(sudoku(i,j),'enable','inactive');
        end
        set(sudoku(i,j),'visible','on');
    end
end

set(text(4),'visible','off');
set(progressbar,'visible','off');
set(pourcentage,'visible','off');
set(handles(2),'string','Revenir au menu principal');
set(handles(2),'callback',@menu);
set(handles(3),'string','Voir la solution');
set(handles(3),'callback',@voirSolution);
set(handles(2),'enable','on');
set(handles(3),'enable','on');

function grilleDifficile(obj, event)

global handles sudoku text GrillePleine delimiteur progressbar pourcentage

set(handles(2),'enable','off');
set(handles(3),'enable','off');

for i = 1:1:3
    set(text(i),'visible','off');   % Suppression des textes d'accueil
    drawnow
end

for i = 1:1:8
    set(delimiteur(i),'visible','off');
end

for i = 1:1:9   % Réinitialisation de la grille
    for j = 1:1:9
        set(sudoku(i,j),'string','');   
        set(sudoku(i,j),'BackgroundColor',[1 1 1]);
        set(sudoku(i,j),'enable','on');
        set(sudoku(i,j),'visible','off');
    end
end

drawnow

set(text(4),'string','Génération de la grille de niveau facile...');
set(text(4),'visible','on');
set(progressbar,'position',[0.1 0.45 0.00001 0.003]);
set(pourcentage,'string','0%');

drawnow

GrillePleine = getGrillePleine(progressbar, pourcentage);   % Synthèse d'une grille pleine

set(text(4),'string','Complexification de la grille. Cette opération peut prendre quelques minutes.');

GrilleDifficile = genGrilleDifficile(GrillePleine, progressbar, pourcentage);   % Création de la grille

for i = 1:1:8
    set(delimiteur(i),'visible','on');
end

for i = 1:1:9   % Mise à jour de la grille graphique
    for j = 1:1:9
        if(GrilleDifficile(i,j) ~= 0)
            set(sudoku(i,j),'string',GrilleDifficile(i,j));
            set(sudoku(i,j),'BackgroundColor',[0.9 0.9 0.9]);
            set(sudoku(i,j),'enable','inactive');
        end
        set(sudoku(i,j),'visible','on');
    end
end

set(text(4),'visible','off');
set(progressbar,'visible','off');
set(pourcentage,'visible','off');
set(handles(2),'string','Revenir au menu principal');
set(handles(2),'callback',@menu);
set(handles(3),'string','Voir la solution');
set(handles(3),'callback',@voirSolution);
set(handles(2),'enable','on');
set(handles(3),'enable','on');


function voirSolution(obj, event)

global sudoku GrillePleine

for i = 1:1:9
    for j = 1:1:9
        set(sudoku(i,j),'string',GrillePleine(i,j));
    end
end

function menu(obj, event)

global handles sudoku text delimiteur

for i = 1:1:4
    set(text(i),'visible','on');
end

for i = 1:1:8
    set(delimiteur(i),'visible','off');
end

for i = 1:1:9   % Réinitialisation de la grille
    for j = 1:1:9
        set(sudoku(i,j),'string','');   
        set(sudoku(i,j),'BackgroundColor',[1 1 1]);
        set(sudoku(i,j),'enable','on');
        set(sudoku(i,j),'visible','off');
    end
end

set(handles(2),'string','Générer une grille de niveau facile');
set(handles(2),'callback',@grilleFacile);
set(handles(3),'string','Générer une grille de niveau difficile');
set(handles(3),'callback',@grilleDifficile);
set(text(4),'string','CHAINTREUIL Rémi et XIONG Yuhui');

function test(obj, event, i, j)

global sudoku

valeur = str2num(get(sudoku(i,j),'string'));

vrai = 1;

for a = 1:1:9
    if(a ~= i)
    
        valeur2 = str2num(get(sudoku(a,j),'string'));
    
        if(valeur == valeur2)
            set(sudoku(i,j),'backgroundcolor',[1 0 0]);
            vrai = 0;
        end
    end
end

for b = 1:1:9
    if(b ~= j)
    
        valeur2 = str2num(get(sudoku(i,b),'string'));
    
        if(valeur == valeur2)
            set(sudoku(i,j),'backgroundcolor',[1 0 0]);
            vrai = 0;
        end
    end
end

ii = (ceil(i/3)-1)*3+1;
jj = (ceil(j/3)-1)*3+1;

for a = ii:1:ii+2
    for b = jj:1:jj+2
        if(~(a == i && b == j))
            valeur2 = str2num(get(sudoku(a,b),'string'));
            
            if(valeur == valeur2)
                set(sudoku(i,j),'backgroundcolor',[1 0 0]);
                vrai = 0;
            end
        end
    end
end

if(vrai == 1)
    set(sudoku(i,j),'backgroundcolor',[1 1 1]);
end