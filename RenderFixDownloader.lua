local GuiLibrary = shared.GuiLibrary
if GuiLibrary then
    if GuiLibrary.SelfDestruct then
        GuiLibrary.SelfDestruct()
    end
end
game.GetService(game, 'StarterGui'):SetCore('SendNotification', ({
    Title = 'Render fixer', 
    Text = "Fixing corrupted files in render. This should take a few seconds :D", 
    Icon = 'rbxassetid://16852575555',
    Duration = 7
}))
if isfolder('vape') then
    writefile("vape/GuiLibrary.lua", game:HttpGet('https://raw.githubusercontent.com/Erchobg/RenderFixer/main/GuiLibrary.lua'))
    writefile("vape/MainScript.lua", game:HttpGet('https://raw.githubusercontent.com/Erchobg/RenderFixer/main/MainScript.lua'))
    writefile('vape/Universal.lua', game:HttpGet('https://raw.githubusercontent.com/Erchobg/RenderFixer/main/Universal.lua'))
    if isfolder('vape/CustomModules') then
        writefile('vape/CustomModules/6872274481.lua', game:HttpGet('https://raw.githubusercontent.com/Erchobg/RenderFixer/main/CustomModules/6872274481.lua'))
    end
    game.GetService(game, 'StarterGui'):SetCore('SendNotification', ({
        Title = 'Render fixer', 
        Text = "Succesfully fixed Render! Executing render now...", 
        Icon = 'rbxassetid://16852575555',
        Duration = 5
    }))
    local executor = (idenityexecutor and idenityexecutor() or getexecutename and getexecutename() or 'Unknown')
        if hookmetamethod and httpServiceRun == nil and  executor:lower():find('krampus') == nil then 
        local httpService = game:GetService('HttpService')
        local lplr = game:GetService('Players').LocalPlayer
        local clonefunc = (clonefunction or clonefunc or function(func) return func end)
        local oldcall
        getgenv().httpServiceRun = function(func, ...) return clonefunc(httpService[func])(httpService, ...) end
        oldcall = hookmetamethod(httpService, '__namecall', function(self, ...)
            if self == httpService then
                return httpServiceRun(getnamecallmethod(), ...)
            end
            return oldcall(self, ...)
        end)
        end

        if isfile and not isfile('vape/NewMainScript.lua') then return lplr:Kick('install render first :skul:') end
        return loadstring(readfile('vape/NewMainScript.lua'))()
else
    game.GetService(game, 'StarterGui'):SetCore('SendNotification', ({
        Title = 'Render fixer', 
        Text = "Render needs to be installed first for the fix to work! Executing the installer in 3 seconds", 
        Icon = 'rbxassetid://16852575555',
        Duration = 3
    }))
    task.wait(3)
    local executor = (idenityexecutor and idenityexecutor() or getexecutename and getexecutename() or 'Unknown')
        if hookmetamethod and httpServiceRun == nil and executor:lower():find('krampus') == nil then 
        local httpService = game:GetService('HttpService')
        local clonefunc = (clonefunction or clonefunc or function(func) return func end)
        local oldcall
        getgenv().ria = 'RIA-TEST'
        getgenv().httpServiceRun = function(func, ...) return clonefunc(httpService[func])(httpService, ...) end
        oldcall = hookmetamethod(httpService, '__namecall', function(self, ...)
            if self == httpService then
                return httpServiceRun(getnamecallmethod(), ...)
            end
            return oldcall(self, ...)
        end)
        end
        game.GetService(game, 'StarterGui'):SetCore('SendNotification', ({
            Title = 'Render fixer', 
            Text = "After installing render execute the fixer again.", 
            Icon = 'rbxassetid://16852575555',
            Duration = 10
        }))
    return loadstring(game.HttpGet(game, 'https://storage.manhackwiz.xyz/Installer/main.lua?ria=RIA-TEST'))()
end