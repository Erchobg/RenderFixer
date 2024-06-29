local RenderFunctions = {}

function RenderFunctions:Initiate()
    --print("Initiated ig")
end
function RenderFunctions:IsolateFunction(...)
    local table = {...}
    for i,v in pairs(table) do
        --print("Name: "..tostring(i).." Thing: "..tostring(table[i])) 
    end
end

return RenderFunctions