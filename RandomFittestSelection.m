% this selection function selects a random chromosome / ant 
% from the fittest 10 chromosomes in the population 
function choice = RandomFittestSelection(population)
    temp_value = 0.1*length(population);
    choice = randi([length(population) - temp_value, length(population)]); 
end