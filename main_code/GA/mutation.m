function value = mutation(P, n)
% P = population (output of Population.m)
% n = number of chromosomes to be mutated
[x1, y1] = size(P);
Z = zeros(n,y1);
for i = 1:n
    % Choose a random parent
    r1 = randi(x1);
    A1 = P(r1,:); % random parent
    r2 = randi(y1); % choose a random bit
    if A1(1,r2) == 1 % invert the mutation bit
        A1(1,r2) = 0;
    else
        A1(1,r2) = 1;
    end
    Z(i,:)=A1;
end
value = Z