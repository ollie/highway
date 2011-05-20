module Highway
	class NoFuelException < Exception
		def message
			"You cannot drive without fuel!"
		end
	end

	class NoRoadException < Exception
		def initialize( meth )
			@meth = meth
		end

		def message
			"You cannot go #{ @meth.capitalize }!"
		end
	end
end
