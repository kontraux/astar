local astar = {}



function astar.path(startx, starty, endx, endy, map)
    local open = {}
    local closed = {}

    local function new_node(x, y)
        local node = {
            x = x;
            y = y;
            f = 0;
            g = 0;
        }
        return node
    end

    table.insert(open, new_node(startx, starty))

    local function get_neighbors(current_node, map)
        local neighbors = nil
        neighbors = {}
        for x = current_node.x - 1, current_node.x + 1 do
            for y = current_node.y - 1, current_node.y + 1 do
                if x ~= current_node.x or y ~= current_node.y then
                    if x > 0 and y > 0 and x < #map and y < #map[x] then
                        if map[x][y] == 0 or map[x][y] == 5 then
                            local node = new_node(x, y)
                            node.g = 1
                            table.insert(neighbors, node)
                        end
                    end
                end
            end
        end
        return neighbors
    end

    local function h(node)
        return node.x - endx + node.y - endy
    end

    local function reconstruct_path()
    end

    local function is_in_table(node, table)
        local in_table = false
        for i, v in pairs(table) do
            if node.x == v.x and node.y == v.y then
                return true
            end
        end
        return in_table
    end

    function astar.get_next(map)
        table.insert(open, {x = startx, y = starty})
        while open[1] do
            ::retry::
        local current_node
        current_node = table.remove(open, 1)

        if current_node.x == endx and current_node.y == endy then
            print("Found a path!")
            reconstruct_path()
            break
        end

        if is_in_table(current_node, closed) == true then
            goto retry
        end
        -- print("Current node: ", current_node.x, current_node.y, "goal: ", endx, endy,  "g-steps: ", current_node.g, "closed n: ", #closed, "open n: ", #open)

        table.insert(closed, current_node)
        if current_node.x == endx then
            print("Matching- ", current_node.x, endx)
        end
        if current_node.y == endy then
            print("Matching- ", current_node.y, endy)
        end


        local neighbors = get_neighbors(current_node, map)
        -- for i,v in pairs(current_node) do print (current_node, i, v) end

        -- for i, node in pairs(neighbors) do
        --     if node.f then

        --         if node.f <= current_node.f then
        --             table.insert(open, node)
        --             current_node = node
        --         end
        --     end
        -- end

        for i, child in pairs(neighbors) do
            child.g = current_node.g + 1
            child.h = h(current_node)
            child.f = child.g + child.h
            if not is_in_table(child, closed) then
                table.insert(open, child)
            end
        end
    end
end

astar.get_next(map)

end


return astar