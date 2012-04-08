function [CompatibleBloc, p] = getCompatibleBloc(Grille, CompatibleLigne, i, n)
    CompatibleBloc = zeros(n,9);
    p = 1;
    
    if(mod(i,3) == 1)   % Si on est sur la premièr ligne d'un bloc...
        CompatibleBloc = CompatibleLigne;   % Pas besoin de test
        p = n;
    elseif(mod(i,3) == 2)   % Si on est sur le deuxième ligne...
        for j = 1:1:n
            b = true;

            for k = 1:1:9   % On compare à la ligne du dessus
                if(CompatibleLigne(j,k) == Grille(i-1,k-mod(k-1,3)) || CompatibleLigne(j,k) == Grille(i-1,k+1-mod(k-1,3)) || CompatibleLigne(j,k) == Grille(i-1,k+2-mod(k-1,3)))
                    b = false;
                    break
                end
            end

            if(b == true)
                CompatibleBloc(p,:) = CompatibleLigne(j,:);
                    p = p+1;
            end
        end
    else    % Si on est sur la troisième ligne...
        for j = 1:1:n
            b = true;

            for k = 1:1:9   % On compare aux deux lignes du dessus
                if(CompatibleLigne(j,k) == Grille(i-1,k-mod(k-1,3)) || CompatibleLigne(j,k) == Grille(i-1,k+1-mod(k-1,3)) || CompatibleLigne(j,k) == Grille(i-1,k+2-mod(k-1,3)) || CompatibleLigne(j,k) == Grille(i-2,k-mod(k-1,3)) || CompatibleLigne(j,k) == Grille(i-2,k+1-mod(k-1,3)) || CompatibleLigne(j,k) == Grille(i-2,k+2-mod(k-1,3)))
                    b = false;
                    break
                end
            end

            if(b == true)
                CompatibleBloc(p,:) = CompatibleLigne(j,:);
                    p = p+1;
            end
        end
    end
    
    p = p-1;    % p représente le nombre de lignes compatibles