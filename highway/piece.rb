module Highway
	class Piece
		attr_accessor :coords, :car, :north, :east, :south, :west

		def initialize( coords )
			@coords = coords
			yield self if block_given?
		end

		def row
			@coords.first
		end

		def col
			@coords.last
		end
	end
end
