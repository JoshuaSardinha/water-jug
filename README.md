# Water Jug Challenge
Water Jug Challenge Flutter implementation.

## The problem
The problem to be solved is the Water Jug Riddle for dynamic inputs (X, Y, Z).

You have an X-gallon and a Y-gallon jug that you can fill from a lake. (Assume lake has unlimited amount
of water.) By using only an X-gallon and Y-gallon jug (no third jug), measure Z gallons of water.

The goal is to build an application to simulate the problem, which should have a UI to display state changes for each state for each jug (Empty, Full or
Partially Full).

### GOALS ###
1. Measure Z gallons of water in the most efficient way.
2. Build a UI where a user can enter any input for X, Y, Z and see the solution.
3. If no solution, display “No Solution”.
### LIMITATIONS ###
• Actions allowed: Fill, Empty, Transfer.

## The algorithm
The problem was solved with a Breadth-First Search solution. The idea is to simulate all the possible states of the buckets with a graph. Each node represents a state of the pair of buckets and each edge represents an action taken with a bucket (emptying, filling or transfering). In this scenario, the first path which fulfills the criteria using the BFS is the most efficient (shortest) one.

## Miscellaneous ##
The data structure architecture was a bit of an overkill for the scope of the project, but it is a demonstration of the usual project standards and good practices.
On the other hand, the state management tools which were used are the most basic ones. A future version using a more reactive approach, with ChangeNotifiers, Providers, Bloc, dependency injections, or others could make the project a bit of a better showcase.
