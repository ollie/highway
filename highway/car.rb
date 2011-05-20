module Highway
	class Car
		attr_accessor :piece, :canvas
		attr_accessor :fuel

		def initialize
			@fuel = 100
		end

		def drive_on( piece )
			raise NoFuelException if @fuel <= 0
			@piece.car = nil if @piece
			@piece = piece
			@piece.car = self
			@fuel -= 1
		end

		def can?( direction )
			@piece.send direction
		end

		def cannot?( direction )
			! can? direction
		end

		def method_missing( meth, *args, &block )
			if meth.match /^(north|east|south|west)$/
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
	end
end
