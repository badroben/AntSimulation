% this crossover function generates a random index 
% and the parents' genes after from that point get crossed
function [child_chromosome1, child_chromosome2] = OnePointCrossover(chromosome1, chromosome2)
    % generate a random number from 1 to the size of the chromosome
    temp_i = randi([1, length(chromosome1)-1]);
    % switch the values of the chromosomes at the cross point. 
    child_chromosome1 = [chromosome1(1:temp_i) chromosome2(temp_i+1:end)];
    child_chromosome2 = [chromosome2(1:temp_i) chromosome1(temp_i+1:end)];
end 