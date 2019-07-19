%% Set paths 

addpath('assignments');
addpath('generators');
addpath('models');

%% Clear workspace

clear;
close all;

%% Basic test

sets = uunifast_mc(2.5, 10, 1, 10, 100, 2);

set = sets(1);

[thetas1, feasible1] = get_execution_rates_mcf(set, 4);
[thetas2, feasible2] = get_execution_rates_mcfluid(set, 4);

%% Evaluation

close all;

m = 4;

utils = 0.1:0.1:1;

mcf_scores = zeros(1, length(utils));
mcfluid_scores = zeros(1, length(utils));

for i=1:length(utils)
    sets = uunifast_mc(m * utils(i), 10, 100, 10, 1000, 2);
    mcf_score = 0;
    mcfluid_score = 0;
    for j=1:length(sets)
        [thetas1, feasible1] = get_execution_rates_mcf(sets(j), m);
        [thetas2, feasible2] = get_execution_rates_mcfluid(sets(j), m);
        mcf_score = mcf_score + feasible1;
        mcfluid_score = mcfluid_score + feasible2;
    end
    mcf_scores(i) = mcf_score;
    mcfluid_scores(i) = mcfluid_score;
end


plot(utils, mcf_scores);
hold;
plot(utils, mcfluid_scores);
