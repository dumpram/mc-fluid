function mcsets = uunifast_mc(u, n, nsets, tmin, tmax, level)
%UUNIFAST Implementation of UUniFast MC task set generation algorithm.

u_sets = [];
p_sets = [];
n_sets =  0;

while n_sets < nsets
    utils = [];
    sum_u = u;
    for i=1:n-1
        next_sum_u = sum_u .* rand^(1 / (n - i));
        utils = [utils, sum_u - next_sum_u];
        sum_u = next_sum_u;
    end
    utils = [utils, next_sum_u];
    discard = false;
    for i=1:n
        if utils(i) > 1
            discard = true;
        end
    end
    
    if ~discard && abs(sum(utils) - u) < 0.05 
        u_sets = [u_sets; utils];
    end
    [n_sets, ~] = size(u_sets);
end

for i=1:nsets
    periods = [];
    for j=1:n
        periods = [periods, tmin + randi(tmax - tmin)];
    end
    p_sets = [p_sets; periods];
end

mcsets = [];
for i=1:nsets
    mctasks = [];
    for j=1:n
        C = [];
        for k=1:level
            C = [C ceil(p_sets(i, j) * u_sets(i, j)) * k];
        end
        mctasks = [mctasks mctask(C, p_sets(i, j), p_sets(i, j), ...
            ceil(rand() * level))];
    end
    
    mcsets = [mcsets mcset(mctasks, level)];
end

end

