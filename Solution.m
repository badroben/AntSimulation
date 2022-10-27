% define problem
% find a way to generate random values for the 10 states
chromosome_length = 30;
string_controller = zeros(1, chromosome_length);

iter = 1;% Number of iterations: repeat "iter" times 
population_size = 20; % Number of chromosomes in population

%% Create a random population 
population = zeros(population_size, chromosome_length);
for i = 1:population_size
    % create a random number between 0 and 9
    temp_chromosome = randi([0,9],1,chromosome_length);
    % check if the values after 3 indeces is between 1 and 4
    for j = 1:3:chromosome_length
          if temp_chromosome(j) == 0 || temp_chromosome(j) > 4
              temp_chromosome(j) = randi([1, 4]);
          end 
    end
    population(i,:)= temp_chromosome;
end

%% always have an extra column at end
population = [population zeros(population_size,1)];

%% calculate the fitness of each chromosome in the population
% and fill the last column with the fitness values
world = dlmread('muir_world.txt',' ');
for k = 1:iter
    %% fill each rows 31st column with the fitness score
    for i = 1:population_size
        [fitness, trail] = simulate_ant(world, population(i, 1:chromosome_length));
        population(i,chromosome_length+1) = fitness;
    end
    
    %% perform elitism, keep best 2
    population = sortrows(population,chromosome_length+1);
    population_new = zeros(population_size,chromosome_length);
    % pick the fittest rows which after sorting, they are the last two in
    % row 19 and 20, we put them in the first 2 rows
    population_new(1:2,:) = population(population_size-1:population_size,1:chromosome_length);
    population_new_num = 2;

    %% repeat until new population is full
    while (population_new_num < 3)
        %% Perform Selection 
        choice1 = TournamentSelection(population, chromosome_length, population_size);
        choice2 = TournamentSelection(population, chromosome_length, population_size);
        
        temp_chromosome_1 = population(choice1, 1:chromosome_length);
        temp_chromosome_2 = population(choice2, 1:chromosome_length);
        
        %% crossover prob 0.8 and random pick cross point
        if (rand < 0.8)
            % chose a cross point from the chromosome size, we dont chose the
            % last one because it would be pointless to swap just in the
            % last column
            [temp_chromosome_1, temp_chromosome_2] = OnePointCrossover(temp_chromosome_1, temp_chromosome_2);
        end
        %% add the new generated chromosomes to the new population
        population_new_num = 3;
    end
end 
% string_controller = [1 1 3 2 7 6 3 1 5 1 8 0 1 7 6 3 4 6 1 1 0 1 5 8 4 4 9 2 9 3];
% [fitness, trail] = simulate_ant(dlmread('muir_world.txt',' '), string_controller);
