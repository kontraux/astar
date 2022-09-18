local map = require 'map'
local astar = require 'astar'

local world = {}

local grid = map.create(30, 35)
map.noise(grid, 0.2)

local startx = math.random(1, #grid)
local starty = math.random(1, #grid[startx])

local endx = math.random(1, #grid)
local endy = math.random(1, #grid[endx])

grid[#grid / 2][#grid / 2] = 5
grid[startx][starty] = "BOOBAS"
local path = astar.path(startx, starty, endx, endy, grid)

for i = 1, #grid do
    io.write("\n")
    for k,v in pairs(grid[i]) do
        io.write(" ", v)
    end
end


return world