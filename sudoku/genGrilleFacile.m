function [Grille, lignes, colonnes] = genGrilleFacile(GrillePleine)
    
    Grille = GrillePleine;
    
    colonnes = randperm(9); % On d�termine un ordre al�atoire de parcours des cases
    lignes = randperm(9);
    
    for a = 1:1:9   % On parcourt l'ensemble des cases
        for b = 1:1:9
            
            j = colonnes(a);
            i = lignes(b);
            
            if(Grille(i,j) ~=0) % Si la case n'est pas vide...

                % On recup�re la liste des chiffres d�j� supprim�s sur sa colonne
                
                chiffressupprimes = [];
                for m = 1:1:9   
                    if(Grille(m,j) == 0)
                        chiffressupprimes = [chiffressupprimes GrillePleine(m,j)];
                    end
                end
                
                % On r�cup�re l'ensemble des chiffres pr�sents sur sa ligne et dans son bloc
                
                p = j-mod(j-1,3);

                if(mod(i,3) == 1)
                    chiffrespresents = [Grille(i,:) Grille(i+1,p:p+2) Grille(i+2,p:p+2)];
                elseif(mod(i,3) == 2)
                    chiffrespresents = [Grille(i,:) Grille(i-1,p:p+2) Grille(i+1,p:p+2)];
                else
                    chiffrespresents = [Grille(i,:) Grille(i-1,p:p+2) Grille(i-2,p:p+2)];
                end
                
                % Si tous les chiffres supprim�s sont pr�sents dans cette liste...
                
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