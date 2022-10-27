% this selection function selects two chromosomes at random and 
% compares them based on their fitness and the choses 
% the one with the highest fitness
function choice = TournamentSelection(pop, pop_length, pop_size)
    chosen_index_1 = randi([1, pop_size]);
    chosen_index_2 = randi([1, pop_size]);
    % compare the fitness based on fitness score column
    if (pop(chosen_index_1, pop_length+1) > pop(chosen_index_2, pop_length+1))
        choice = chosen_index_1;
    else 
        choice = chosen_index_2;
    end
end 