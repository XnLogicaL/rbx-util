local exceptions = require(script.Parent.exceptions)
local tb_util = {}

local function assertwarn(condition, message)
	if condition == false or condition == nil then
		warn(message)
		return true
	end
end

function tb_util.sort(__iterable: {any})
	exceptions.raise("FeatureNotActivated", "tb_util.sort has not been activated yet")
end

function tb_util.key_of(__iterable: {any}, __value: any)
	for index, obj in pairs(__iterable) do
		if obj == __value then
			return index
		end
	end
	return nil
end

function tb_util.index_of(__iterable: {any}, __value: any)
	local fromFind = table.find(__iterable, __value)
	if fromFind then return fromFind end

	return tb_util.keyOf(__iterable, __value)
end

function tb_util.remove(tbl0, tbl1)
	local nt = table.create(#tbl0 + #tbl1)
	local t2 = table.move(tbl0, 1, #tbl0, 1, nt)
	return table.move(tbl1, 1, #tbl1, #tbl0 + 1, nt)
end

function tb_util.take(tbl, n)
	return table.move(tbl, 1, n, 1, table.create(n))
end

function tb_util.insert_and_get_index(tbl, value)
	tbl[#tbl + 1] = value
	return #tbl
end

function tb_util.contains(tbl, value)
	return tb_util.indexOf(tbl, value) ~= nil -- This is kind of cheatsy but it promises the best performance.
end

function tb_util.skip(tbl, n)
	return table.move(tbl, n+1, #tbl, 1, table.create(#tbl-n))
end

function tb_util.range(tbl, start, finish)
	return table.move(tbl, start, finish, 1, table.create(finish - start + 1))
end

function tb_util.skip_and_take(tbl, skip, take)
	return table.move(tbl, skip + 1, skip + take, 1, table.create(take))
end

function tb_util.join(__iterable1: {any}, __iterable2: {any})
	local nt = table.create(#__iterable1 + #__iterable2)
	local t2 = table.move(__iterable1, 1, #__iterable2, 1, nt)
	return table.move(__iterable2, 1, #__iterable2, #__iterable1 + 1, nt)
end

function tb_util.for_each(__iterable: {any}, __handler: (index: number, element: any, ...any) -> (any))
	for i, v in __iterable do
		__handler(i, v)
	end
end

function tb_util.count(__iterable: {number})
	local count = 0
	for i, v in __iterable do
		if assertwarn(type(v) == "number", `element #{i} is not a number, skipping`) then
			continue
		end
		count += v
	end
	return count
end

function tb_util.copy(__iterable: {any})
	return {unpack(__iterable)}
end

return setmetatable({}, {
	__index = function(tbl, index)
		if tb_util[index] ~= nil then
			return tb_util[index]
		else
			return table[index]
		end
	end
})
