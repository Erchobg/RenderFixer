--local httpservice = cloneref(game.GetService(game, 'HttpService'))
local httpservice = game:GetService("HttpService")

local ria = "RIA-TEST"

local alreadydonefuncs = {}

local renderwrite = function(file, data)
    local directories = file:split('/')
    local last
    writefile('ria.ren', "RIA-TEST")
    for i,v in next, ({'vape', 'vape/Render', 'vape/assets', 'vape/Profiles', 'vape/CustomModules', 'vape/Libraries'}) do 
        if not isfolder(v) then 
            makefolder(v)
        end
    end
    writefile('vape/commithash.txt', 'main')
    return writefile('vape/'..file, data)
end

local profiles, assets, libraries = {}, {}, {}
local modules = {'Universal.lua', 'NewMainScript.lua', '6872274481.lua', 'GuiLibrary.lua', 'MainScript.lua'}

local installation = {}

function installation:createmessage(mes)
    local title = "Render downloader"
    if mes["title"] then
        title = mes["title"]
    end
    local desc = mes["desc"]
    local icon = 'rbxassetid://16852575555'
    game.GetService(game, 'StarterGui'):SetCore('SendNotification', ({
        Title = title, 
        Text = desc, 
        Icon = icon,
        Duration = 5
    }))
end

function installation:addstep(func)
    table.insert(installation, func)
end

function installation:start()
    for i,v in pairs(installation) do
        print(i)
        if i == #installation then
            installation[i]()
            break
        else
            installation[i]()
        end
    end
end

installation:addstep(function() 
    if isfolder('vape/Render') then 
        delfolder('vape/Render')
    end
    installation:createmessage({["desc"] = "Installation shouldn\'t take too long, hang tight!"})
end)
installation:addstep(function()
    installation:createmessage({["desc"] = "Fetching Profiles from Github"})
    local res = game:HttpGet('https://api.github.com/repos/SystemXVoid/Render/contents/Libraries/Settings')
    if res ~= '404: Not Found' then 
        for i,v in next, httpservice:JSONDecode(res) do 
            task.wait()
            if type(v) == 'table' and v.name then 
                table.insert(profiles, v.name)
            end
        end
    end
end)
installation:addstep(function()
    installation:createmessage({["desc"] = 'Fetching assets from Github'})
    local res = game:HttpGet('https://api.github.com/repos/7GrandDadPGN/VapeV4ForRoblox/contents/assets')
    if res ~= '404: Not Found' then 
        for i,v in next, httpservice:JSONDecode(res) do 
            task.wait()
            if type(v) == 'table' and v.name then 
                table.insert(assets, v.name)
            end
        end
    end
end)
installation:addstep(function()
    installation:createmessage({["desc"] = 'Fetching Libraries from Github'})
    local res = game:HttpGet('https://api.github.com/repos/7GrandDadPGN/VapeV4ForRoblox/contents/Libraries')
    if res ~= '404: Not Found' then 
        for i,v in next, httpservice:JSONDecode(res) do 
            task.wait()
            if type(v) == 'table' and v.name then 
                table.insert(libraries, v.name)
            end
        end
    end
end)
installation:addstep(function()
    installation:createmessage({["desc"] = 'Downloading Custom Features'})
    for i,v in next, modules do 
        local id = v:gsub('.lua', '')
        if tonumber(id) then 
            renderwrite('CustomModules/'..v, ([[return loadstring(game:HttpGet('renurl'))()]]):gsub('renurl', 'https://storage.manhackwiz.xyz/packages/'..v..'?ria='..ria))
        else
            renderwrite(v, ([[return loadstring(game:HttpGet('renurl'))()]]):gsub('renurl', 'https://storage.manhackwiz.xyz/packages/'..v..'?ria='..ria))
        end
    end
end)
installation:addstep(function()
    installation:createmessage({["desc"] = 'Downloading default settings'})
    for i,v in next, profiles do 
        renderwrite('Profiles/'..v, game:HttpGet('https://raw.githubusercontent.com/SystemXVoid/Render/source/Libraries/Settings/'..v))
    end
end)
installation:addstep(function()
    installation:createmessage({["desc"] = 'Downloading assets'})
    for i,v in next, assets do 
        renderwrite('assets/'..v, game:HttpGet('https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/assets/'..v))
    end
end)
installation:addstep(function()
    installation:createmessage({["desc"] = 'Downloading Libraries'})
    for i,v in next, libraries do 
        renderwrite('Libraries/'..v, game:HttpGet('https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/Libraries/'..v))
    end
end)
installation:addstep(function()
    installation:createmessage({["desc"] = 'Fixing render bugs'})
    writefile("vape/GuiLibrary.lua", game:HttpGet('https://raw.githubusercontent.com/Erchobg/RenderFixer/main/GuiLibrary.lua'))
    writefile("vape/MainScript.lua", game:HttpGet('https://raw.githubusercontent.com/Erchobg/RenderFixer/main/MainScript.lua'))
    writefile('vape/Universal.lua', game:HttpGet('https://raw.githubusercontent.com/Erchobg/RenderFixer/main/Universal.lua'))
    if isfolder('vape/CustomModules') then
        writefile('vape/CustomModules/6872274481.lua', game:HttpGet('https://raw.githubusercontent.com/Erchobg/RenderFixer/main/6872274481.lua'))
    end
    installation:createmessage({["desc"] = "Succesfully downloaded Render"})
    installation:createmessage({["desc"] = "Loading Render now..."})
    loadstring(readfile('vape/NewMainScript.lua'))()
end)

installation:start()