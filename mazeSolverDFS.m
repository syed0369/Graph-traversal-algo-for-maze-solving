function [stepsDFS, timeDFS, pathDFS] = mazeSolverDFS(maze, start, goal)
    [rows, cols] = size(maze);
    visited = false(rows, cols);
    parent = zeros(rows, cols, 2);
    stepsDFS = 0;
    stack = [];
    stack = [stack; start];
    visited(start(1), start(2)) = true;
    tic;
    while ~isempty(stack)
        current = stack(end, :);
        stack(end, :) = []; 
        stepsDFS = stepsDFS + 1;
        if isequal(current, goal)
            pathDFS = reconstructPath(parent, goal);
            timeDFS = toc;
            return;
        end
        
        neighbors = getNeighbors(current, maze);
        for i = 1:size(neighbors, 1)
            neighbor = neighbors(i, :);
            if ~visited(neighbor(1), neighbor(2))
                visited(neighbor(1), neighbor(2)) = true;
                parent(neighbor(1), neighbor(2), :) = current;
                stack = [stack; neighbor];
            end
        end
    end
    pathDFS = []; 
    toc;
    timeDFS = -1;
return

function neighbors = getNeighbors(node, maze)
    [rows, cols] = size(maze);
    deltas = [0, 1; 1, 0; -1, 0; 0, -1]; 
    neighbors = [];
    
    for i = 1:size(deltas, 1)
        neighbor = node + deltas(i, :);
        if all(neighbor >= 1) && all(neighbor <= [rows, cols]) && maze(neighbor(1), neighbor(2)) == 0
            neighbors = [neighbors; neighbor];
        end
    end
return

function path = reconstructPath(parent, goal)
    path = [];
    current = goal;
    
    while any(current ~= 0)
        path = [current; path];
        current = squeeze(parent(current(1), current(2), :))';
    end
return
