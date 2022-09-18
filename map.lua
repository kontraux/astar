local map = {}


function map:new(row, column)
    local grid = {}
    setmetatable(grid, self)
    self.__index = self
    for x = 1, row do
        grid[x] = {}
        for y = 1, column do
            grid[x][y] = 0
        end
    end
    return grid
end

function map:add_noise(percent)
    for x = 1, #self do
        for y = 1, #self[x] do
            if math.random() < percent * 0.01 then
                self[x][y] = 1
            end
        end
    end
end

function map:random_nodes()
    ::retry::
    local start_node = {
        x = math.random(1, #self)
    }
    start_node.y = math.random(1, #self[start_node.x])
    local end_node = {
        x = math.random(1, #self)
    }
    end_node.y = math.random(1, #self[end_node.x])

    if self[start_node.x][start_node.y] == 0 and self[end_node.x][end_node.y] == 0 then
        return start_node, end_node
    else
        goto retry
    end
end

function map:wall()
    for x = 1, #self do
        for y = 1, #self[x] do
            if x == 1 or y == 1 or x == #self or y == #self[x] then
                self[x][y] = 1
            end
        end
    end
    return self
end

function map:write_path(path)
    for _, node in pairs(path) do
        self[node.x][node.y] = " "
    end
end

function map:print()
    for _,t in pairs(self) do 
        io.write("\n")
        for i, v in pairs(t) do
            io.write(v)
        end
    end
end

return map