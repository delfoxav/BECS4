function value = crossover(P, n)
    % P = population
    % n = number of chromosomes to be crossover
    r1 = 0;
    r2 = 0;
    [x1 y1] = size(P);
    Z = zeros(2*n,y1);
    for i = 1:n
        r1 = randi(x1,1,2);
        while r1(1)==r2(1)
            r1 = randi(x1,1,2);
        end
        A1 = P(r1(1),:); % Parent 1
        A2 = P(r1(2),:); % Parent 2
        r2 = 1+randi(y1-1); % random cutting point
        B1 = A1(1,r2:y1);
        A1(1,r2:y1) = A2(1,r2:y1);
        A2(1,r2:y1) = B1;
        Z(2*i-1,:) = A1; % offspring 1
        Z(2*i,:) = A2; % offspring 2
    end
    value = Z;
