-- Will add more functions soon
local exceptions = require(script.Parent.exceptions)
local std_string = string

local str = {}

function str.convert(_str: string): {string}
    local finalstr = {}
    for i=1, _str:len() do
        table.insert(finalstr, _str:sub(i, i+1))
    end
    return finalstr
end

return setmetatable({}, {
    __index = function(_, index)
        if str[index] then
            return str[index]
        elseif std_string[index] then
            return std_string[index]
        else
            exceptions.raise("IndexError", index .. " is not a valid member of str")
        end
    end,
    __newindex = function(tbl, index, _)
        tbl[index] = nil
        exceptions.raise("ExecutionError", "Do not add new indexes during runtime, edit source instead.")
    end
})