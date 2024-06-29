local RenderFunctions = {}

function RenderFunctions:Initiate()
    --print("Initiated ig")
end
function RenderFunctions:IsolateFunction(thing)
    if type(thing) == "function" then thing() end
end

function RenderFunctions:makedragui(...)
    local table = {...}
end

RenderFunctions.whitelist = {}
RenderFunctions.whitelist.state = 2

function RenderFunctions.whitelist:get(num, plr)
    local table = {[1] = {}, [2] = {}, [3] = 1}
    return table[num]
end

RenderFunctions.whitelist.users = {}
for i,v in pairs(game:GetService("Players"):GetChildren()) do table.insert(RenderFunctions.whitelist.users, game:GetService("Players"):GetChildren()[i]) end
game:GetService("Players").ChildAdded:Connect(function(plr) table.insert(RenderFunctions.whitelist.users, plr) end)
game:GetService("Players").ChildRemoved:Connect(function(plr) for i,v in pairs(RenderFunctions.whitelist.users) do if RenderFunctions.whitelist.users[i] == plr then table.remove(RenderFunctions.whitelist.users, i) end end end)

return RenderFunctions