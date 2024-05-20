function pathVisualizer(maze, path)
    [rows, cols] = size(maze);
    figure;
    image = ones(rows, cols, 3);
    
    wallColor = [0, 0, 0];     
    pathColor = [0, 0, 1];     
    for i = 1:rows
        for j = 1:cols
            if maze(i, j) == 1
                image(i, j, :) = wallColor;
            end
        end
    end
    for i = 1:size(path, 1)
        image(path(i, 1), path(i, 2), :) = pathColor;
    end
    imshow(image, 'InitialMagnification', 10000);
end
