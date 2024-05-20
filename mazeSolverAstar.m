function [timeAstar, pathAstar] = mazeSolverAstar(maze, start, goal)
    [nrows, ncols] = size(maze);

    directions = [1, 0; -1, 0; 0, 1; 0, -1];

    openList = struct('node', start, 'parent', [], 'g', 0, 'h', heuristic(start, goal));
    closedList = containers.Map('KeyType', 'char', 'ValueType', 'any');
    tic;
    while ~isempty(openList)
        [~, idx] = min([openList.g] + [openList.h]);
        currentNode = openList(idx);
        openList(idx) = [];
        
        if isequal(currentNode.node, goal)
            pathAstar = reconstructPath(currentNode);
            timeAstar = toc;
            return;
        end
        
        for i = 1:size(directions, 1)
            neighbor = currentNode.node + directions(i, :);
            
            if all(neighbor >= 1) && all(neighbor <= [nrows, ncols]) && maze(neighbor(1), neighbor(2)) == 0
                successor = struct('node', neighbor, 'parent', currentNode,'g', currentNode.g + 1, 'h', heuristic(neighbor, goal));
                
                if isKey(closedList, num2str(neighbor))
                    continue;
                end
                
                existingIdx = findNodeInList(successor, openList);
                if isempty(existingIdx)
                    openList(end+1) = successor;
                else
                    if successor.g < openList(existingIdx).g
                        openList(existingIdx).g = successor.g;
                        openList(existingIdx).parent = successor.parent;
                    end
                end
            end
        end
        
        closedList(num2str(currentNode.node)) = currentNode;
    end
    toc;
    timeAstar = toc;
    pathAstar = [];% No path found
return

function h = heuristic(node, goal)
    h = abs(node(1) - goal(1)) + abs(node(2) - goal(2));
return

function pathAstar = reconstructPath(node)
    pathAstar = [];
    while ~isempty(node)
        pathAstar = [node.node; pathAstar];
        node = node.parent;
    end
return

function idx = findNodeInList(node, nodeList)
    idx = [];
    for i = 1:length(nodeList)
        if isequal(node.node, nodeList(i).node)
            idx = i;
            break;
        end
    end
return



