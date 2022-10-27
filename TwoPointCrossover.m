% this crossover function generates two random numbers
% between 1 and the length of the chromosome and swaps the genes 
function [child_chromosome1, child_chromosome2] = TwoPointCrossover(chromosome1, chromosome2)
    % generate two random points for crossover
    point1 = randi([1, length(chromosome1)]);
    point2 = randi([1, length(chromosome1)]);
    while (point2 == point1)
        point2 = randi([1, length(chromosome1)]); %so that point 1 != point2
    end
    % check if the point1 is higher than point2 
    if (point1 < point2)
        % this stores the genes from 1 to the first point, and from the
        % first point in second parent to the second point to form the
        % first part of the child chromosome
        first_part_of_chromosome1 = [chromosome1(1:point1) chromosome2(point1+1:point2)];
        % finish the child chromosome with rest of the genes from the first
        % parent after point 2
        child_chromosome1 = [first_part_of_chromosome1 chromosome1(point2+1:end)];
        first_part_of_chromosome2 = [chromosome2(1:point1) chromosome1(point1+1:point2)];
        child_chromosome2 = [first_part_of_chromosome2 chromosome2(point2+1:end)];
    else % point2 is higher 
        first_part_of_chromosome1 = [chromosome1(1:point2) chromosome2(point2+1:point1)];
        child_chromosome1 = [first_part_of_chromosome1 chromosome1(point1+1:end)];
        first_part_of_chromosome2 = [chromosome2(1:point2) chromosome1(point2+1:point1)];
        child_chromosome2 = [first_part_of_chromosome2 chromosome2(point1+1:end)];
    end
end 