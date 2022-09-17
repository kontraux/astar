local map = {}

function map.create(rows, columns)
    local grid = {}
    for x = 1, rows do
        grid[x] = {}
        for y = 1, columns do
            grid[x][y] = 0
        end
    end
    return grid
end

function map.noise(grid, amount)
    for x = 1, #grid do
        for y = 1, #grid[x] do
            if math.random() < amount then
                grid[x][y] = 1
            end
        end
    end
end


return map