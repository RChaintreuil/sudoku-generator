function b = testSolutions(M, b)

if(~exist('b'))
    b = 0;
end

% On cherche un zéro
zero = min(find(M(:)==0));
if isempty(zero)  % S'il n'y en a pas...
    b = 1;  % C'est qu'on a une solution !
else % Sinon, on teste tous les chiffres possibles dans la case
    [i,j] = ind2sub([9,9],zero);
    for k=1:9
        ii = (ceil(i/3)-1)*3+1;
        jj = (ceil(j/3)-1)*3+1;
        mm = M(ii:ii+2,jj:jj+2); % Indices du bloc 3x3 de la case
        if(~(any(M(i,:)==k) || any(M(:,j)==k) || any(mm(:)==k)))  % On vérifie que le chiffre est possible
            M(i,j) = k;  % On le met dans la case
            b = testSolutions(M,b); % Et on appelle la fonction récursivement
            
            if(b ==1)
                break;
            end
        end
    end
end