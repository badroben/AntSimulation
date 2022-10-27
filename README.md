# AntSimulation
Using MATLAB to implement a Genetic Algorithm to build a better ant through evolution

The main task of this program is to attempt building a better ant through evolution using the concept of [Genetic Algorithms] (https://en.wikipedia.org/wiki/Genetic_algorithm). 

# Defining the problem: 
Each ant must survive on its own in a world represented by a 2D grid of cells by following trails of food. Each cell in
the world either has a piece of food or is empty and the cells wrap-around (so, moving up
when in the top row leaves the ant in the bottom row of the grid). The environment is called "John Muir" trail that consists of a 32 by 32 grid containing 89
food cells. which can be seen in the file () where 1 represents a piece of food and 0 represents nothing. 

The ant’s position at any point in time can be specified by a cell location and a heading
(north, south, east, or west). The ant always starts in the cell in the upper left corner,
facing right (east). At the beginning of each time-step it gets one bit of sensory
information: whether there is food in the cell in front of the cell it currently occupies
(i.e., the cell it would move to if it moved forward). At each time-step it has one of four
possible actions. It can move forward one cell; turn right ninety degrees without changing
cells; turn left ninety degrees without changing cells; or do nothing. If an ant moves onto
a food-cell, it consumes the food and the food disappears; when the ant leaves that cell,
the cell is empty. The fitness of the ant is rated by counting how many food elements it consumes in 200 time-steps. (An ant that consumes 10 cells worth of food receives a fitness score of 10.)
