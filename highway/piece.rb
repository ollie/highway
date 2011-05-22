module Highway
	class Piece
		attr_accessor :coords, :car, :north, :east, :south, :west
		attr_reader :station

		def initialize( coords )
			@coords = [ coords[:row], coords[:col] ]
			@station = coords[:station]
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
