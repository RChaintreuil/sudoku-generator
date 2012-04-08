function Grille = getGrillePleine(progressbar, pourcentage)

    tic     % Début du timer
    
    set(progressbar,'visible','on');
    set(pourcentage,'visible','on');
    drawnow

    nombres = [1 2 3 4 5 6 7 8 9];
    Liste = perms(nombres); % Génération de l'ensemble des permutations
    n = length(Liste);

    Grille = zeros(9,9);

    choix = ceil(n*rand(1,1));  % Choix de la première ligne
    Grille(1,:) = Liste(choix,:);
    
    set(progressbar,'position',[0.1 0.45 0.8/9 0.003]);
    set(pourcentage,'string','11%');
    drawnow

    for i = 2:1:9   % Itération pour les 8 lignes suivantes

        [CompatibleLigne, n] = getCompatibleLigne(Grille, Liste, i, n);

        [CompatibleBloc, p] = getCompatibleBloc(Grille, CompatibleLigne, i, n);

        choix = floor(p*rand(1,1))+1;   % Choix de la ligne
        Grille(i,:) = CompatibleBloc(choix,:);
        
        set(progressbar,'position',[0.1 0.45 i*0.8/9 0.003]);
        set(pourcentage,'string',strcat(num2str(i*11),'%'));
        drawnow

        Liste = CompatibleLigne;

    end

    Temps = toc;    % Fin du timer

    % disp(sprintf('Grille pleine générée en %s secondes.', Temps));