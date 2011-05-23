module Highway
	class Car
		MAX_FUEL = 100

		attr_accessor :piece, :canvas, :fuel

		def initialize
			max_fuel
		end

		def drive_on( piece )
			raise NoRoadException unless piece.is_a? Piece
			raise NoFuelException if @fuel <= 0
			@piece.car = nil if @piece
			@piece = piece
			@piece.car = self
			@fuel -= 1
			max_fuel if @piece.station
		end

		def can?( direction )
			@piece.send direction
		end

		def cannot?( direction )
			! can? direction
		end

		def method_missing( meth, *args, &block )
			if meth.match /^w|d|s|a|north|east|south|west$/
				self.class.send :define_method, meth, do
					begin
						raise NoRoadException, meth if cannot? meth
						drive_on @piece.send meth
						@canvas.redraw
					rescue NoRoadException => e
						puts e.message
					rescue NoFuelException => e
						puts e.message
						exit
					end
				end.call
			else
				super
			end
		end

		def drive_around
			3.times do
				6.times { north }
				7.times { west }
				1.times { south }
				6.times { west }
				5.times { south }
				13.times { east }
			end
		end

		def drive_around_short
			3.times do
				6.times { w }
				7.times { a }
				1.times { s }
				6.times { a }
				5.times { s }
				13.times { d }
			end
		end

		def max_fuel
			@fuel = MAX_FUEL
		end
	end
end
