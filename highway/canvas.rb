# encoding: utf-8
module Highway
	class Canvas
		# ┌─┬─┐
		# │ │ │
		# ├─┼─┤
		# │ │ │
		# └─┴─┘
		EAST_SOUTH				= '┌'
		EAST_WEST				= '─'
		EAST_SOUTH_WEST			= '┬'
		SOUTH_WEST				= '┐'
		NORTH_SOUTH				= '│'
		NORTH_SOUTH_WEST		= '┤'
		NORTH_WEST				= '┘'
		NORTH_EAST_WEST			= '┴'
		NORTH_EAST				= '└'
		NORTH_EAST_SOUTH		= '├'
		NORTH_EAST_SOUTH_WEST	= '┼'
		ORPHAN					= 'x'
		CAR						= '▒'
		STATION					= '▓'

		alias_method :original_to_s, :to_s
		attr_reader :map
		attr_accessor :car, :delay

		def initialize( map )
			@map = map
			@data = rows.times.map { Array.new cols }
		end

		def rows
			@map.rows
		end

		def cols
			@map.cols
		end

		def place_pieces( pieces )
			pieces.each do |piece|
				@data[ piece.row ][ piece.col ] = piece
			end
		end

		def paint
			system 'clear'
			[ header, body, footer ].join "\n"
		end

		def draw
			puts paint
		end

		def redraw
			sleep @delay if @delay
			puts paint
		end

		private

			# ┌─┬──────────────┐
			# │ │   Highway!   │
			# │ │01234567890123│
			# ├─┼──────────────┤
			def header
				o = []
				o << EAST_SOUTH + EAST_WEST + EAST_SOUTH_WEST + EAST_WEST * cols + SOUTH_WEST
				o << NORTH_SOUTH + ' ' + NORTH_SOUTH + 'Highway!'.center( cols ) + NORTH_SOUTH
				o << NORTH_SOUTH + ' ' + NORTH_SOUTH + (0..cols - 1).to_a.map { |i| i.to_s.split( // ).last }.join.ljust( cols ) + NORTH_SOUTH
				o << NORTH_EAST_SOUTH + EAST_WEST + NORTH_EAST_SOUTH_WEST + EAST_WEST * cols + NORTH_SOUTH_WEST
				o.join "\n"
			end

			# │.│    ...       │
			# │5│    ─┤        │
			# │6│     └─┐      │
			# │.│    ...       │
			def body
				i = 0
				@data.map do |row|
					o = []
					o << NORTH_SOUTH
					o << i.to_s.split( // ).last
					o << NORTH_SOUTH
					o += row.map { |p| symbol_for p }
					o << NORTH_SOUTH
					i += 1
					o.join
				end.join "\n"
			end

			# └─┴──────────────┘
			def footer
				o = []
				o << NORTH_EAST + EAST_WEST + NORTH_EAST_WEST + EAST_WEST * cols + NORTH_WEST
				o << "Fuel: #{ @car.fuel } %"
				o.join "\n"
			end

			def symbol_for( piece )
				return ' ' unless piece.is_a? Highway::Piece

				# Car!
				return CAR if piece.car
				return STATION if piece.station

				# Cross road
				return NORTH_EAST_SOUTH_WEST if piece.north and piece.east and piece.south and piece.west

				# T junctions
				return EAST_SOUTH_WEST	if !piece.north and  piece.east and  piece.south and  piece.west
				return NORTH_SOUTH_WEST	if  piece.north and !piece.east and  piece.south and  piece.west
				return NORTH_EAST_WEST	if  piece.north and  piece.east and !piece.south and  piece.west
				return NORTH_EAST_SOUTH	if  piece.north and  piece.east and  piece.south and !piece.west

				# Roads
				return NORTH_SOUTH		if  piece.north and !piece.east and  piece.south and !piece.west
				return EAST_WEST		if !piece.north and  piece.east and !piece.south and  piece.west

				# Corners
				return SOUTH_WEST		if !piece.north and !piece.east and  piece.south and  piece.west
				return NORTH_WEST		if  piece.north and !piece.east and !piece.south and  piece.west
				return NORTH_EAST		if  piece.north and  piece.east and !piece.south and !piece.west
				return EAST_SOUTH		if !piece.north and  piece.east and  piece.south and !piece.west

				# Stops
				return NORTH_SOUTH		if piece.north or piece.south
				return EAST_WEST		if piece.east or piece.west

				# Unknown
				return ORPHAN
			end
	end
end
