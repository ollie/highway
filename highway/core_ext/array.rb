class Array
	def north
		[ self.first - 1, self.last ]
	end

	def east
		[ self.first, self.last + 1 ]
	end

	def south
		[ self.first + 1, self.last ]
	end

	def west
		[ self.first, self.last - 1 ]
	end
end
