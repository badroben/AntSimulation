% this crossover operator crosses the values of the
%  two parents based on a random number between 0 and 1
function [child_chromosome1, child_chromosome2] = UniformCrossover(chromosome1, chromosome2)
    child_chromosome1 = zeros(1, length(chromosome1));
    child_chromosome2 = zeros(1, length(chromosome1));
    for i = 1:length(chromosome1)
        % generate a random value between 0 and 1
        if (rand >= 0.5)
            % gene from parent 1 goes to child 1 and 
            % gene from parent 2 goes to child 2
            child_chromosome1(1, i) = chromosome1(1, i);
            child_chromosome2(1, i) = chromosome2(1, i);
        else
            % gene from parent 2 goes to child 1 and 
            % gene from parent 1 goes to child 2
            child_chromosome1(1, i) = chromosome2(1, i);
            child_chromosome2(1, i) = chromosome1(1, i);
        end
    end
end