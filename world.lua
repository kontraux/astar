local map = require 'map'
local astar = require 'astar'

local world = {}


local grid = map:new(20, 150)
grid:wall()
grid:add_noise(40)

local start_node, end_node = grid:random_nodes()

local path = astar.route(start_node, end_node, grid)

grid:write_path(path)
grid:print()

return world