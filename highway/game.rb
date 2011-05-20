module Highway
	class Game
		DELAY = 0.1

		attr_accessor :canvas, :road, :car

		def initialize
			yield self if block_given?
		end

		def start_at( coords )
			@car.drive_on @road.piece_at coords
		end

		def start
			puts @canvas.paint

			while @car.can? :north
				@car.north
				redraw
			end

			while @car.can? :west
				@car.west
				redraw
			end

			while @car.can? :south
				@car.south
				redraw
			end

			while @car.can? :east
				@car.east
				redraw
			end

			start
		end

		def redraw
			sleep DELAY
			puts @canvas.paint
		end
	end
end
