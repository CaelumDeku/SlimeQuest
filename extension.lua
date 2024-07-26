local meta = getmetatable("") -- get the string metatable

meta.__add = function(a,b) -- the + operator
    return a..b
end

meta.__sub = function(a,b) -- the - operator
    return a:gsub(b,"")
end

meta.__mul = function(a,b) -- the * operator
    return a:rep(b)
end

-- if you have string.explode (check out the String exploding snippet) you can also add this:
meta.__div = function(a,b) -- the / operator
    return a:explode(b)
end

meta.__index = function(a,b) -- if you attempt to do string[id]
    if type(b) ~= "number" then
        return string[b]
    end
    return a:sub(b,b)
end

function string.explode(str, div)
    assert(type(str) == "string" and type(div) == "string", "invalid arguments")
    local o = {}
    while true do
        local pos1,pos2 = str:find(div)
        if not pos1 then
            o[#o+1] = str
            break
        end
        o[#o+1],str = str:sub(1,pos1-1),str:sub(pos2+1)
    end
    return o
end