function [CompatibleLigne, m] = getCompatibleLigne(Grille, Liste, i, n)
    CompatibleLigne = zeros(n,9);
    m = 1;

    for j = 1:1:n   % On parcourt toutes les permutations
        
        b = true;
        
        for k = 1:1:9   % On vérifie si elles sont compatibles avec la ligne du dessus
            if(Liste(j,k) == Grille(i-1,k))
                    b = false;
                    break
            end
        end
        
        if(b == true)   % Si oui...
            CompatibleLigne(m,:) = Liste(j,:);  % On les ajoute à CompatibleLigne
                m = m+1;
        end       
    end
    
    m = m-1;    % m représente le nombre de permutationc compatibles