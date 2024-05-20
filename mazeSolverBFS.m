function [timeBFS, pathBFS] = mazeSolverBFS(maze, start, goal)
    [rows, cols] = size(maze);
    stepsBFS = 0;
    queue = {start};  
    visited = false(rows, cols);  
    visited(start(1), start(2)) = true;
    parent = zeros(rows, cols, 2);  
    tic;
    while ~isempty(queue)
        current = queue{1};
        queue(1) = [];
        stepsBFS = stepsBFS + 1;
        if isequal(current, goal)
            pathBFS = reconstructPath(parent, start, goal);
            timeBFS = toc;
            return;
        end
        
        neighbors = getNeighbors(current, maze, rows, cols);
        for i = 1:length(neighbors)
            neighbor = neighbors{i};
            if ~visited(neighbor(1), neighbor(2))
                visited(neighbor(1), neighbor(2)) = true;
                parent(neighbor(1), neighbor(2), :) = current;
                queue{end+1} = neighbor;
            end
        end
    end
    toc;
    timeBFS = -1;
    pathBFS = [];  
return

function path = reconstructPath(parent, start, goal)
    path = goal;
    current = goal;
    
    while ~isequal(current, start)
        current = squeeze(parent(current(1), current(2), :))';
        path = [current; path];
    end
return

function neighbors = getNeighbors(position, maze, rows, cols)
    row = position(1);
    col = position(2);
    directions = [-1, 0; 1, 0; 0, -1; 0, 1];  
    neighbors = {};
    
    for i = 1:size(directions, 1)
        newRow = row + directions(i, 1);
        newCol = col + directions(i, 2);
        
        if newRow >= 1 && newRow <= rows && newCol >= 1 && newCol <= cols && maze(newRow, newCol) == 0
            neighbors{end+1} = [newRow, newCol];
        end
    end
return
