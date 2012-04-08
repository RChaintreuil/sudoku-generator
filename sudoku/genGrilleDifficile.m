function Grille = genGrilleDifficile(GrillePleine, progressbar, pourcentage)
    
    Grille = GrillePleine;
    
    % On génère d'abord une grille facile
    
    colonnes = randperm(9); % On détermine un ordre aléatoire de parcours des cases
    lignes = randperm(9);
    
    for a = 1:1:9   % On parcourt l'ensemble des cases
        for b = 1:1:9
            
            j = colonnes(a);
            i = lignes(b);
            
            if(Grille(i,j) ~=0) % Si la case n'est pas vide...

                % On recupère la liste des chiffres déjà supprimés sur sa colonne
                
                chiffressupprimes = [];
                for m = 1:1:9   
                    if(Grille(m,j) == 0)
                        chiffressupprimes = [chiffressupprimes GrillePleine(m,j)];
                    end
                end
                
                % On récupère l'ensemble des chiffres présents sur sa ligne et dans son bloc
                
                p = j-mod(j-1,3);

                if(mod(i,3) == 1)
                    chiffrespresents = [Grille(i,:) Grille(i+1,p:p+2) Grille(i+2,p:p+2)];
                elseif(mod(i,3) == 2)
                    chiffrespresents = [Grille(i,:) Grille(i-1,p:p+2) Grille(i+1,p:p+2)];
                else
                    chiffrespresents = [Grille(i,:) Grille(i-1,p:p+2) Grille(i-2,p:p+2)];
                end
                
                % Si tous les chiffres supprimés sont présents dans cette liste...
                
                b = 1;

                for k = 1:1:length(chiffressupprimes)
                    if(~any(chiffrespresents(:)==chiffressupprimes(k)))
                        b=0;
                    end
                end

                if(b == 1)
                    Grille(i,j) = 0;    % On peut supprimer la case
                end
            end
        end
    end
    
    casesremplies = 0;
    
    for i = 1:1:9   % On détermine le nombre de cases encore remplies
        for j = 1:1:9
            if(Grille(i,j) ~= 0)
                casesremplies = casesremplies + 1;
            end
        end
    end
    
    u = 0;  % Compteur de cases parcourues
    
    set(progressbar,'position',[0.1 0.45 0.00001 0.003]);
    set(pourcentage,'string','0%');
    drawnow
    
    for j = 1:1:9   % Pour chaque colonne
        for i = 1:1:9   % On teste chaque ligne            
            
            if(Grille(i,j) ~= 0)    % Si la case est remplie...
                
                u = u+1;
                
                set(progressbar,'position',[0.1 0.45 (u/35)*0.8 0.003]);
                set(pourcentage,'string',strcat(num2str(ceil(u/casesremplies*100-1)),'%'));
                drawnow

                ii = (ceil(i/3)-1)*3+1;
                jj = (ceil(j/3)-1)*3+1;
                mm = Grille(ii:ii+2,jj:jj+2); % Indices du bloc 3x3 de la case
                
                b = 1;
                
                for k = 1:1:9
                    if(k ~= Grille(i,j) && ~(any(Grille(i,:)==k) || any(Grille(:,j)==k) || any(mm(:)==k)))
                        GrilleTemp = Grille;
                        GrilleTemp(i,j) = k;    % On tente de la remplir avec tous les autres chiffres possibles
                        
                        M = resolve(GrilleTemp, lignes, colonnes);
                        
                        if(testSolutions(M) == 1)   % Si la grille obtenue a une solution...
                            b = 0;  % C'est que la solution n'est plus unique
                        end
                    end
                end
                
                if(b == 1)
                    Grille(i,j) = 0;    % Sinon on peut supprimer la case
                end            
                
            end
            
        end
    end