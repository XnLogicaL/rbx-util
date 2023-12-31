local FreeThread: thread? = nil

local function FunctionPasser(fn, ...)
	local AquiredThread = FreeThread
	FreeThread = nil
	fn(...)
	FreeThread = AquiredThread
end

local function Yielder()
	while true do
		FunctionPasser(coroutine.yield())
	end
end

return function<T...>(fn: (T...) -> (), ...: T...)
	if not FreeThread then
		FreeThread = coroutine.create(Yielder)
		coroutine.resume(FreeThread :: any)
	end

	task.spawn(FreeThread :: thread, fn, ...)
end
