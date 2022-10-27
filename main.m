%% a menu pops up with the two first options the user can chose from 
% which are: default in which the user uses the default settings 
% optional in which the user picks the operators to use.
msg = "Which setting would you like to use?";
opts = ["Default", "Optional"];
setting = menu(msg, opts);
if (opts(setting) == "Default")
    selection = "ts"; %TournamentSelection
    cross_over = "uc"; %UniformCrossover
    mutation = "rfm"; %RandomFlipMutation
elseif (opts(setting) == "Optional")
    % ask the user to pick a selection operator
    msg = "Which selection operator would you like to use?";
    opts = ["RouletteWheelSelection", "TournamentSelection", "RandomFittestSelection"];
    answer = menu(msg, opts);
    if (opts(answer) == "RouletteWheelSelection")
        selection = "rws";
    elseif (opts(answer) == "TournamentSelection")
        selection = "ts";
    elseif (opts(answer) == "RandomFittestSelection")
        selection = "rfs";
    end
    % ask the user to pick a crossover operator
    msg = "Which crossover operator would you like to use?";
    opts = ["OnePointCrossover", "TwoPointCrossover", "UniformCrossover"];
    answer = menu(msg, opts);
    if (opts(answer) == "OnePointCrossover")
        cross_over = "opc";
    elseif (opts(answer) == "TwoPointCrossover")
        cross_over = "tpc";
    elseif (opts(answer) == "UniformCrossover")
        cross_over = "uc";
    end
    % ask the user to pick a mutation operator
    msg = "Which mutation operator would you like to use?";
    opts = ["SwapMutation", "RandomFlipMutation", "AdditionMutation"];
    answer = menu(msg, opts);
    if (opts(answer) == "SwapMutation")
        mutation = "sm";
    elseif (opts(answer) == "RandomFlipMutation")
        mutation = "rfm";
    elseif (opts(answer) == "AdditionMutation")
        mutation = "am";
    end
end
% ask the user to enter the number of generations desired
prompt = "Enter the number of generations: ";
dlgtitle = 'Input';
dims = [1 40];
answer = inputdlg(prompt,dlgtitle,dims);
% convert from cell to an integer
Ngen = str2num(cell2mat(answer));
fitness_data = zeros(1, Ngen);

%% start the algorithm with the options specified

% start the timer
tic;
chromosome_length = 30;
string_controller = zeros(1, chromosome_length);

population_size = 100; % Number of chromosomes in population

%% Create a random population 
population = zeros(population_size, chromosome_length);
for i = 1:population_size
    % create a random number between 0 and 9
    temp_chromosome = randi([0,9],1,chromosome_length);
    % check if the values after each 3 indexes are between 1 and 4
    for j = 1:3:chromosome_length
          if temp_chromosome(j) == 0 || temp_chromosome(j) > 4
              temp_chromosome(j) = randi([1, 4]);
          end 
    end
    population(i,:)= temp_chromosome;
end

%% extra column at end to store the fitness
population = [population zeros(population_size,1)];

%% repeat Ngen times; each time generates a new population
world = dlmread('muir_world.txt',' ');
% extra column at end to store the fitness
population = [population zeros(population_size,1)];

for k = 1:Ngen
    % calculate the fitness of each chromosome / ant in the population
    % and fill the last column with the fitness values
    for i = 1:population_size
        [fitness, trail] = simulate_ant(world, population(i, 1:chromosome_length));
        population(i,chromosome_length+1) = fitness;
    end
    
    %% perform elitism, keep best 2
    population = sortrows(population,chromosome_length+1);
    % add the fittest ant to the fitness_data
    fitness_data(1, k) = population(end, chromosome_length+1);
    population_new = zeros(population_size,chromosome_length);
    % pick the fittest rows which after sorting are last two
    population_new(1:2,:) = population(population_size-1:population_size,1:chromosome_length);
    population_new_num = 2;

    %% repeat until new population is full
    while (population_new_num < population_size)
        %% Perform selection based on user's settings
        % RouletteWheelSelection
        if selection == "rws"
            weights= population(:,chromosome_length+1)/sum(population(:,chromosome_length+1));
            choice1 = RouletteWheelSelection(weights);
            choice2 = RouletteWheelSelection(weights);

            temp_chromosome_1 = population(choice1, 1:chromosome_length);
            temp_chromosome_2 = population(choice2, 1:chromosome_length);
        % TournamentSelection
        elseif selection == "ts"
            choice1 = TournamentSelection(population, chromosome_length, population_size);
            choice2 = TournamentSelection(population, chromosome_length, population_size);

            temp_chromosome_1 = population(choice1, 1:chromosome_length);
            temp_chromosome_2 = population(choice2, 1:chromosome_length);
        % RandomFittestSelection
        elseif selection == "rfs"
            choice1 = RandomFittestSelection(population);
            choice2 = RandomFittestSelection(population);

            temp_chromosome_1 = population(choice1, 1:chromosome_length);
            temp_chromosome_2 = population(choice2, 1:chromosome_length);
        end
        %% crossover prob 0.8
        if (rand < 0.8)
            % OnePointCrossover
            if (cross_over == "opc")
                [temp_chromosome_1, temp_chromosome_2] = OnePointCrossover(temp_chromosome_1, temp_chromosome_2);
            % TwoPointCrossover
            elseif (cross_over == "tpc")
                [temp_chromosome_1, temp_chromosome_2] = TwoPointCrossover(temp_chromosome_1, temp_chromosome_2);
            % UniformCrossover
            elseif (cross_over == "uc")
                [temp_chromosome_1, temp_chromosome_2] = UniformCrossover(temp_chromosome_1, temp_chromosome_2);
            end 
        end 
        
        %% mutation prob 0.2 
        if (rand < 0.2)
            % SwapMutation
            if (mutation == "sm")
                temp_chromosome_1= SwapMutation(temp_chromosome_1);
            % RandomFlipMutation
            elseif(mutation == "rfm")
                temp_chromosome_1= RandomFlipMutation(temp_chromosome_1);
            % AdditionMutation
            elseif(mutation == "am")
                temp_chromosome_1= AdditionMutation(temp_chromosome_1);
            end
        end
        if (rand < 0.2)
            if (mutation == "sm")
                temp_chromosome_2= SwapMutation(temp_chromosome_2);
            elseif(mutation == "rfm")
                temp_chromosome_2= RandomFlipMutation(temp_chromosome_2);
            elseif(mutation == "am")
                temp_chromosome_2= AdditionMutation(temp_chromosome_2);
            end
        end
        
        %% add the new generated chromosomes to the new population
        population_new_num = population_new_num + 1;
        % fill the chromosome at the new index with the resulted chromosome 
        population_new(population_new_num,:) = temp_chromosome_1;
        % add second chromosome if not at the end
        if (population_new_num < population_size)
            population_new_num = population_new_num + 1;
            population_new(population_new_num,:) = temp_chromosome_2;
        end
    end
      
    %% replace population with the new one and we now 
    % improve the new population
    population(:,1:chromosome_length) = population_new;
    
end 

 %% sort the last population and return the best finness and its trail
for i = 1:population_size
        [fitness, trail] = simulate_ant(world, population(i, 1:chromosome_length));
        population(i,chromosome_length+1) = fitness;
end
population = sortrows(population,chromosome_length+1);
[best_fitness, best_trail] = simulate_ant(world, population(end, 1:chromosome_length));

%% plotting the fitness score of the most-fit in each generation

hf = figure(1); set(hf,'Color',[1 1 1]);
hp = plot(1:Ngen,100*fitness_data/89,'r');
set(hp,'LineWidth',2);

axis([0 Ngen 0 100]); grid on;
xlabel('Generation number');
ylabel('Ant fitness [%]');
title('Ant fitness as a function of generation');

%%  plot showing the trail of the most-fit ant in the final generation
world_grid = world;

% display the John Moir Trail (world)
world_grid = rot90(rot90(rot90(world_grid)));
xmax = size(world_grid,2);
ymax = size(world_grid,1);

hf = figure(2); set(hf,'Color',[1 1 1]);
for y=1:ymax
    for x=1:xmax
        if(world_grid(x,y) == 1)
            h1 = plot(x,y,'sk');
            hold on
        end
    end
end
grid on

% display the fittest Individual trail
for k=1:size(best_trail,1)
    h2 = plot(best_trail(k,2),33-best_trail(k,1),'*m');
    hold on
end
axis([1 32 1 32])
title_str = sprintf("John Muri Trail - Hero Ant fitness %d%% in %d generation ",uint8(100*best_fitness/89), Ngen);
title(title_str)
lh = legend([h1 h2],'Food cell','Ant movement');
set(lh,'Location','SouthEast');

% stop the timer
toc;