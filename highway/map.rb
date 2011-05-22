module Highway
	class Map
		alias_method :original_to_s, :to_s
		attr_reader :raw, :data, :coords, :rows, :cols

		def initialize( map_file )
			@data, @coords, @rows, @cols = [], [], 0, 0
			@map_file = map_file
			read_file
			parse_data
			calculate_coords
		end

		def paint
			o = []
			o << '*' * ( @cols + 2 )
			@data.each { |row| o << '*' + row.map { |i| i || ' ' }.join + '*' }
			o << '*' * ( @cols + 2 )
			o.join "\n"
		end

		private

			def read_file
				@raw = File.read( @map_file ).split( "\n" )
			end

			def parse_data
				@raw.each do |line|
					matches = line.match /^\*([ xS]+)\*$/
					next if matches.nil? or matches[1].nil?
					pieces = matches[1].split( // ).map { |i| i.strip.empty? ? nil : i }
					@rows += 1
					@cols = pieces.size if pieces.size > @cols
					@data << pieces
				end
			end

			def calculate_coords
				@data.each_with_index do |row, row_index|
					row.each_with_index do |col, col_index|
						next if col.nil?
						h = {
							:row => row_index,
							:col => col_index,
							:station => col == 'S',
						}
						@coords << h
					end
				end
			end
	end
end
