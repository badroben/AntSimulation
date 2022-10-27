function chromosome = RandomFlipMutation(chromosome1)
    position_to_change = randi([1, length(chromosome1)]);
    positions =  1:3:length(chromosome1);
    % check if the random variable generated belongs to the vector (1, 4,
    % 7, ..)
    if ne(find(positions == position_to_change), 0)
        new_value = randi([1, 4]);
        chromosome1(1, position_to_change) = new_value;
    else 
        new_value = randi([0, 9]);
        chromosome1(1, position_to_change) = new_value;
    end
    chromosome = chromosome1;
end 