% this mutation operator swaps two values from the ant 
% at random positions only if it is not in positions 1, 4, 7, 10, ...etc
function chromosome = SwapMutation(chromosome1)
    r1 = randi([1, length(chromosome1)]);
    r2 = randi([1, length(chromosome1)]);
    % Regenerate random values if the values are the same, or
    % if both values are one of the positions (1, 4, 7, 10, ... ) where the
    % value has to be 1 to 4 so only swap if both values do not belong to
    % the pos vector
    pos =  1:3:length(chromosome1);
    while (r1 == r2 | ne(find(pos == r1), 0) & ne(find(pos == r2), 0))
        r1 = randi([1, length(chromosome1)]);
        r2 = randi([1, length(chromosome1)]);
    end 
    % only do the swap if both variables are different, and
    % don't belong to (1, 4, 7, 10, ...)
    % here we store the value at r1 before we overwrite it
    temp_v = chromosome1(1, r1);
    chromosome1(1, r1) = chromosome1(1, r2);
    chromosome1(1, r2) = temp_v;
    chromosome = chromosome1;
end 