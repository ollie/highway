module Highway
	class Road
		attr_accessor :pieces

		def init_pieces( canvas )
			@pieces = canvas.map.coords.map { |coords| Piece.new coords }
			connect_pieces
		end

		def piece_at( coords )
			@pieces.find { |i| i.coords == coords }
		end

		private

			def connect_pieces
				@pieces.each do |piece|
					coords = piece.coords
					piece.north	= piece_at coords.north	if piece_at coords.north
					piece.east	= piece_at coords.east	if piece_at coords.east
					piece.south	= piece_at coords.south	if piece_at coords.south
					piece.west	= piece_at coords.west	if piece_at coords.west
				end
			end
	end
end
