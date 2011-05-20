module Highway
	class Car
		attr_accessor :piece

		def drive_on( piece )
			@piece.car = nil if @piece
			@piece = piece
			@piece.car = self
		end

		def can?( direction )
			@piece.send direction
		end

		def method_missing( meth, *args, &block )
			if meth.match /^(north|east|south|west)$/
				self.class.send :define_method, meth, do
					if can? meth
						drive_on @piece.send meth
					else
						puts "Cannot go #{ meth }!"
					end
				end.call
			else
				super
			end
		end
	end
end
