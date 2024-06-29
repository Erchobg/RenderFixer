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

RenderFunctions.playerTags = {}

RenderFunctions.whitelist = {}
RenderFunctions.whitelist.state = 2

function RenderFunctions.whitelist:get(position, plr)
    plr = plr or lplr
    local defaultTab = {'STANDARD', true, 1, 'SPECIAL USER', 'FFFFFF', true, 0, 'ABCDEFGH'}
    return defaultTab[tonumber(position or 1)]
end

function RenderFunctions:GithubHash(...)
    return 'main'
end

function RenderFunctions:TagPlayer(...)

end

function RenderFunctions:WhitelistBed(a)
    return false
end

function RenderFunctions:GetFile(...)
    warn("Unable to do this task in this version of RenderFunctions!")
end

function RenderFunctions:DebugWarning(text)
    if not type(text) == "string" then text = tostring(text) end
    warn(text)
end

RenderFunctions.whitelist.users = {}
for i,v in pairs(game:GetService("Players"):GetChildren()) do table.insert(RenderFunctions.whitelist.users, game:GetService("Players"):GetChildren()[i]) end
game:GetService("Players").ChildAdded:Connect(function(plr) table.insert(RenderFunctions.whitelist.users, plr) end)
game:GetService("Players").ChildRemoved:Connect(function(plr) for i,v in pairs(RenderFunctions.whitelist.users) do if RenderFunctions.whitelist.users[i] == plr then table.remove(RenderFunctions.whitelist.users, i) end end end)

return RenderFunctions