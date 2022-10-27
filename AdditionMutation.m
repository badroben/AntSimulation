% this function choses a random value from positions 1, 4, 7, ...etc
%  and adds 1 to gene value 
function chromosome = AdditionMutation(chromosome1)
    position_to_change = randi([1, length(chromosome1)]);
    positions =  1:3:length(chromosome1);
    % check if the random variable generated belongs to the vector (1, 4,
    % 7, ..)
    if (ne(find(positions == position_to_change), 0))
        % if the value in this position is not 4 add 1
        if (chromosome1(1, position_to_change) ~= 4)
            new_value = chromosome1(1, position_to_change) + 1;
        else % value is 4
            new_value = 1;
        end
        chromosome1(1, position_to_change) = new_value;
    else 
        % if the value in this position is not 9 add 1
        if (chromosome1(1, position_to_change) ~= 9)
            new_value = chromosome1(1, position_to_change) + 1;
        else % value is 9
            new_value = 0;
        end
        chromosome1(1, position_to_change) = new_value;
    end
    chromosome = chromosome1;
end 