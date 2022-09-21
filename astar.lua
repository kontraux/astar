local astar = {}

function astar.route(start_node, end_node, map)
local open = {}
local closed = {}

local first_node = {
    x = start_node.x,
    y = start_node.y,
    h = 0,
    g = 0,
    f = 0,
}

table.insert(open, first_node)
local current_node

    local function new_node(x, y)
        local node = {
            x = x,
            y = y,
        }
        node.h = math.abs(node.x - end_node.x) + math.abs(node.y - end_node.y)
        node.g = current_node.g + 1
        node.f = node.g + node.h
        return node
    end

    local function get_neighbors(node)
        local neighbors = {}
        for x = node.x - 1, node.x + 1 do
            for y = node.y - 1, node.y + 1 do
                if x ~= node.x or y ~= node.y then
                    if x > 0 and y > 0 and x < #map and y < #map[x] then
                        if map[x][y] == 0 then
                            local neighbor_node = new_node(x, y)
                            table.insert(neighbors, neighbor_node)
                        end
                    end
                end
            end
        end
        return neighbors
    end

    local function in_table(node, table)
        local value = false
        for i, v in pairs(table) do
            if node.x == v.x and node.y == v.y then
                value = true
            end
        end
        return value
    end

    local function reconstruct_path(node)
        local path = {}
        while node.parent.x ~= start_node.x and node.parent.y ~= start_node.y do
            table.insert( path, { x = node.parent.x, y = node.parent.y } )
            for i,v in pairs(closed) do
                if node.parent.x == v.x and node.parent.y == v.y then
                    node = v
                end
            end
        end
        return path
    end

    local function lowestf(t)
        local key = 1
        local v = t[key].f
        for i = 1, #t do
            if t[i].f < v then
                key = i
            end
        end
        return table.remove(t, key)
    end

    local path = {}
    local function begin()
        local count = 1
        ::continue::
        count = count + 1
        local message = "No path found!"
        assert(open[1], message)

        current_node = lowestf(open)
        print("Current node: x: ", current_node.x, "y: ", current_node.y, "h: ", current_node.h, "g: ", current_node.g, "f: ", current_node.f)

        if current_node.x == end_node.x and current_node.y == end_node.y then
            print("Found a path from ", start_node.x, start_node.y, "to ", end_node.x, end_node.y)
            print("count: ", count)
            path = reconstruct_path(current_node)
            return path
        end

        if in_table(current_node, closed) then
            goto continue
        end
        table.insert(closed, current_node)

        local neighbors = get_neighbors(current_node)
        for _, node in pairs(neighbors) do
            node.parent = {
                x = current_node.x,
                y = current_node.y,
            }
            if not in_table(node, closed) and not in_table(node, open) then
                table.insert(open, node)
            end
        end
        goto continue
        return path
    end
    begin()
    return path
end


return astar