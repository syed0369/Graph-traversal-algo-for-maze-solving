clear variables;
clc;
close all;
maze = [
    0, 0, 0, 0, 1, 1, 1, 0, 0;
    0, 1, 0, 0, 1, 0, 0, 0, 1;
    0, 0, 1, 0, 0, 0, 1, 0, 1;
    1, 0, 0, 0, 0, 0, 0, 0, 0;
    1, 1, 1, 0, 0, 1, 0, 1, 0;
    0, 0, 0, 0, 1, 1, 0, 0, 0;
    0, 1, 0, 0, 0, 0, 1, 0, 1;
    0, 1, 0, 0, 1, 0, 0, 0, 0;
    0, 1, 0, 1, 0, 1, 1, 0, 0;
];
start = [1, 1];
goal = size(maze);
[stepsDFS, timeDFS, pathDFS] = mazeSolverDFS(maze, start, goal);
[timeBFS, pathBFS] = mazeSolverBFS(maze, start, goal);
[timeAstar, pathAstar] = mazeSolverAstar(maze, start, goal);
if isempty(pathDFS)
    disp("No path found.");
else
    disp("Path found:");
    
    disp("Steps taken to reach goal using DFS = ");
    disp(stepsDFS);
    disp("Time taken to reach goal using DFS = ");
    disp(timeDFS);
    disp(pathDFS);
    pathVisualizer(maze, pathDFS);
    title('Maze and Path Visualization of DFS');

    disp("Steps taken to reach goal using BFS = ");
    stepsBFS = size(pathBFS);
    disp(stepsBFS(1));
    disp("Time taken to reach goal using BFS = ");
    disp(timeBFS);
    disp(pathBFS);
    pathVisualizer(maze, pathBFS);
    title('Maze and Path Visualization of BFS');
    
    disp("Steps taken to reach goal using A* = ");
    stepsAstar = size(pathAstar);
    disp(stepsBFS(1));
    disp("Time taken to reach goal using A* = ");
    disp(timeAstar);
    disp(pathAstar);
    pathVisualizer(maze, pathAstar);
    title('Maze and Path Visualization of A*');
end
Algo = ['DFS', 'BFS', 'A*'];
time = [timeDFS, timeAstar, timeBFS];
figure;
bar(time);
xlabel('Algorithms');
ylabel('Time'); 
title('Comparison of Algorithms');
grid on;
steps = [stepsDFS, stepsBFS(1), stepsAstar(1)];
figure;
bar(steps);
xlabel('Algorithms');
ylabel('Number of solution steps'); 
title('Comparison of Algorithms');
grid on;
