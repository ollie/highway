module Highway
	class Game
		attr_accessor :canvas, :road, :car

		def initialize
			yield self if block_given?
		end

		def start_at( coords )
			@car.drive_on @road.piece_at coords
		end

		def start
			@canvas.draw
			@car.drive_around
		end
	end
end
