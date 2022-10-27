# AntSimulation
Using MATLAB to implement a Genetic Algorithm to build a better ant through evolution

The main task of this program is to attempt building a better ant through evolution using the concept of [Genetic Algorithms](https://en.wikipedia.org/wiki/Genetic_algorithm). 

# Defining the problem 
Each ant must survive on its own in a world represented by a 2D grid of cells by following trails of food. Each cell in
the world either has a piece of food or is empty and the cells wrap-around (so, moving up
when in the top row leaves the ant in the bottom row of the grid). The environment is called "John Muir" trail that consists of a 32 by 32 grid containing 89
food cells. which can be seen in this [file](https://github.com/badroben/AntSimulation/blob/main/muir_world.txt)
 where 1 represents a piece of food and 0 represents nothing. 

The ant’s position at any point in time can be specified by a cell location and a heading
(north, south, east, or west). The ant always starts in the cell in the upper left corner,
facing right (east). At the beginning of each time-step it gets one bit of sensory
information: whether there is food in the cell in front of the cell it currently occupies
(i.e., the cell it would move to if it moved forward). At each time-step it has one of four
possible actions. It can move forward one cell; turn right ninety degrees without changing
cells; turn left ninety degrees without changing cells; or do nothing. If an ant moves onto
a food-cell, it consumes the food and the food disappears; when the ant leaves that cell,
the cell is empty. The fitness of the ant is rated by counting how many food elements it consumes in 200 time-steps. (An ant that consumes 10 cells worth of food receives a fitness score of 10.)

The controller for our ant will consist of a 10-state finite state machine (FSM). At each
time step, the ant takes the following actions:
1- Read the sensor value.
2- The controller changes state based on the sensor value/
3- The ant takes an action indicated by the new state (which may result in a change
in position).
4- If the ant is in a cell with food, the ant eats the food.
Each of the ten states in the FSM controller has a unique identifier (a number ranging
from 0 to 9) and the content of that state can be represented by three digits:

![image](https://user-images.githubusercontent.com/60741379/198379657-861a8137-06c6-4272-a9d7-0da51258cc31.png)

The ant begins its life with the controller in state 0. The entire genetic material for an ant
thus consists of 10 states, each of which is represented by three digits, for a total of 30
digits.

# Solving the problem
The algorithm utilises 3 different types of [selection](https://en.wikipedia.org/wiki/Selection_(genetic_algorithm)), [crossover](https://en.wikipedia.org/wiki/Crossover_(genetic_algorithm)), and [mutation](https://en.wikipedia.org/wiki/Mutation_(genetic_algorithm)) operators. The program asks the user for using a default setting (this setting is the combination of operators which I have experimented with and got the best results) or if they want to use an optional setting in which the user chooses 1 operator for selection, crossover, and mutation, the user is also asked to enter the number of generations. 
Based on the operators and the generations the program outputs two plots, one which illustrates the ant's trail and the fitness percentage
![image](https://user-images.githubusercontent.com/60741379/198382044-40be975f-88d7-493c-aff0-6270a54a9458.png) <br/>
the other plot shows the fitness score of the most-fit ant in each
generation. <br/>
![image](https://user-images.githubusercontent.com/60741379/198382694-8ff61993-2629-41bd-b0d8-132ad89b5ad3.png) <br/>

Based on my experiments, my default setting consists of: Tournament Selection, Uniform Crossover, and Random Flip Mutation, in which the average of the fittest ant was between 91% and 100% fitness meaning it has consumed most the food in the trail as shown in the image below:
![image](https://user-images.githubusercontent.com/60741379/198387468-ae15b6f8-2ae2-4dbf-9392-c180bb5a03cf.png) <br/>
This is the second plot: <br/>
![image](https://user-images.githubusercontent.com/60741379/198387649-9831ff12-8485-45b1-936d-e9b35bf892c5.png)

Note: The program operates in less than 5s. 
