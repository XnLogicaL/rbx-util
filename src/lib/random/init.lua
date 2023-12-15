export type random = {
	__refine__: (__iterable: {any}) -> ({any}),
	__rng__: Random,
	seed: (__seed: number) -> (),
	random: () -> (number),
	randint: (m: number, n: number) -> (number),
	choice: (__iterable: {any}) -> (any),
	shuffle: (__iterable: {any}) -> ({any}),
	_randbelow: (n: number, maxsize: number) -> (number)
}

random = {
	__refine__ = function(__iterable: {any})
		assert(#__iterable > 0, "given iterable has insufficient quantity of elements.")
		return {unpack(__iterable)}
	end,
	__rng__ = Random.new(),
	seed = function(__seed: number)
		local self: random = random
		self.__rng__ = Random.new(__seed)
	end,
	random = function()
		local self: random = random
		return self.__rng__:NextNumber()a
	end,
	randint = function(m: number, n: number)
		assert(m, "given minimum is not an integer")
		assert(n, "given maximum is not an integer")
		local self: random = random
		return self.__rng__:NextInteger(m, n)
	end,
	choice = function(__iterable: {any})
		assert(#__iterable > 0, "given iterable has insufficient quantity of elements.")
		local self: random = random
		local __refined = self.__refine__(__iterable)
		return __refined[self.__rng__:NextInteger(1, #__refined)]
	end,
	shuffle = function(__iterable: {any})
		assert(#__iterable > 1, "given iterable has insufficient quantity of elements.")
		local self: random = random
		for i, _ in __iterable do
			local j = self
			__iterable[i], __iterable[j] = __iterable[j], __iterable[i]
		end
	end,
	_randbelow = function(n: number, maxsize: number)
		assert(n, "argument 1 missing or nil")
		local self: random = random
		local max_size = maxsize or 1
		if n >= max_size then
			warn("Underlying random() generator does not supply \n",
				"enough bits to choose from a population range this large.\n",
				"To remove the range limitation, add a getrandbits() method.")
			return math.floor(random() * n)
		end
		local rem = max_size % n
		local limit = (max_size - rem) / max_size
		local r = self.__rng__:NextNumber()
		while r >= limit do
			r = self.__rng__:NextNumber()
		end
		return math.floor(r * max_size) % n
	end,
}

return random :: random
