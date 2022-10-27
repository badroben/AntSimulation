% In Roulette Wheel Selection, A set of weights represents the probability of selection of each
% chromosome in a group of choices. It returns the index of the chosen chromosome.

function choice = RouletteWheelSelection(weights)
  % create a cumulative vector of the probabilties/weights passed as a
  % parameter 
    accumulation = cumsum(weights);
    % generate p which is from 0 to 1
    p = rand();
    chosen_index = -1;
    for index = 1 : length(accumulation)
        if (accumulation(index) > p)
        % break out of the loop as soon as the index found with a
        % accumulative probability higher than p
        chosen_index = index;
        break;
        end
    end
choice = chosen_index;