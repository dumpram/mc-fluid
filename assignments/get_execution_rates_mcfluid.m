function [thetas, feasible] = get_execution_rates_mcfluid(mcset, m)
%GET_EXECUTION_RATES_MCFLUID Summary of this function goes here
%   Detailed explanation goes here

tasks = mcset.mctasks;

tasks_hi = []; % only HI tasks are considered
uls = [];
uhs = [];

for i=1:length(mcset.mctasks)
    task = mcset.mctasks(i);
    if (task.L == 2)
        tasks_hi = [tasks_hi mcset.mctasks(i)];
        uls = [uls task.utilization_lo()];
        uhs = [uhs task.utilization_hi()];
    end
end

X = sdpvar(length(tasks_hi), 1, 'full');

f = 0;

for i=1:length(tasks_hi)
    f = f + uls(i) * (uhs(i) - uls(i)) / (X(i) + uls(i));
end

cons = [];
cons = [cons sum(X) - m + mcset.utilization_hi() <= 0];
cons = [cons -X <= 0];

for i=1:length(tasks_hi)
    cons = [cons X(i) - 1 + uhs(i) <= 0];
end

ops = sdpsettings('solver', 'bmibnb');
y = optimize(cons, f, ops);

thetas = X;
feasible = y.problem == 0;