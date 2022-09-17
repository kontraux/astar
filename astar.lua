local astar = {}

function astar.new(startx, starty, endx, endy)
    local open = {
        { startx, starty }
    }
    local closed = {}
    local f -- Total cost of path to n
    local g -- Cost so far
    local h -- Cost from n to goal (heuristic)
    while startx ~= endx and starty ~= endy  do
        local n = table.remove(open, 1)
        table.insert(closed, n)
        print(n[1], n[2])
        for i = -1, 1 do
            for j = -1, 1 do
                for i,v in pairs(closed) do
                    if i ~= v[1] and j ~= v[2] then

                    end
                end
            end
        end
    end
end



return astar