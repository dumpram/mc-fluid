function [thetas, feasible] = get_execution_rates_mcf(mcset, m)
%GET_EXECUTION_RATES_MCF Summary of this function goes here
%   Detailed explanation goes here

tasks = mcset.mctasks;
n = length(tasks);
thetas = zeros(n, 2);

uhs = [];
for i=1:n
    if (tasks(i).L == 2)
        uhs = [uhs tasks(i).utilization_hi()];
    end
end

ro = max([mcset.utilization_lo() / m, mcset.utilization_hi() / m, ...
    max(uhs)]);

if (ro <= 1)
    for i=1:n
        if tasks(i).L == 2
            u_h = tasks(i).utilization_hi();
            u_l = tasks(i).utilization_lo();
            thetas(i, 2) = u_h / ro;
            thetas(i, 1) = u_l * thetas(i, 2) / ... 
                (thetas(i, 2) - (u_h - u_l));
        else
            thetas(i, 1) = tasks(i).utilization_lo(); 
        end
    end
else
    feasible = 0;
    return;
end

if sum(thetas(:, 1)) > m
    feasible = 0;
else 
    feasible = 1;
end


end

