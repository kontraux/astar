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
        node.h = node.x - end_node.x + node.y - end_node.y
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

    local path = {}
    local function begin()
        ::continue::
        current_node = table.remove(open, 1)

        if current_node.x == end_node.x and current_node.y == end_node.y then
            print("Found a path from ", start_node.x, start_node.y, "to ", end_node.x, end_node.y)
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
            if not in_table(node, closed) then
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