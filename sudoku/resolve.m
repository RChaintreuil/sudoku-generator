function M = resolve(Grille, lignes, colonnes)

    for a = 9:-1:1
        for b = 9:-1:1
            
            i = lignes(b);
            j = colonnes(a);    % On parcourt toutes les cases dans le sens inverse à celui de la génération des trous
            
            if(Grille(i,j) == 0)    % Pour chaque case vide...
                
                % On récupère l'ensemble des chiffres présents sur sa ligne, sa colonne et dans son bloc
                
                p = j-mod(j-1,3);

                if(mod(i,3) == 1)
                    chiffrespresents = [Grille(i,:) Grille(:,j)' Grille(i+1,p:p+2) Grille(i+2,p:p+2)];
                elseif(mod(i,3) == 2)
                    chiffrespresents = [Grille(i,:) Grille(:,j)' Grille(i-1,p:p+2) Grille(i+1,p:p+2)];
                else
                    chiffrespresents = [Grille(i,:) Grille(:,j)' Grille(i-1,p:p+2) Grille(i-2,p:p+2)];
                end
                
                chiffrespossibles = [];
                
                for k = 1:1:9
                    if(~(any(chiffrespresents(:) == k)))
                        chiffrespossibles = [chiffrespossibles k];  % On détermine la liste des nombres possibles
                    end
                end
                
                if(size(chiffrespossibles,2) == 1)  % S'il n'y en a qu'un seul
                    Grille(i,j) = chiffrespossibles(1); % On peut remplir la case
                end
            end
        end
    end
    
    M = Grille;