module Highway
	class Map
		alias_method :original_to_s, :to_s
		attr_reader :raw, :data, :coords, :rows, :cols, :settings

		def initialize( map_file )
			@data, @coords, @settings, @rows, @cols = [], [], {}, 0, 0
			@map_file = map_file
			read_file
			parse_data
			calculate_coords
		end

		def paint
			o = []
			o << '  ' + '*' * ( @cols + 2 )
			@data.each_with_index do |row, row_index| 
				tmp = []
				if row_index % 10 == 0
					tmp << row_index.to_s.split(//).first
				else
					tmp << ' '
				end
				tmp << row_index.to_s.split(//).last
				tmp << '*'
				tmp << row.map { |i| i || ' ' }.join
				tmp << '*'
				o << tmp.join
			end
			o << '  ' + '*' * ( @cols + 2 )
			o << '   ' + (0...@cols).to_a.map { |i| i.to_s.split(//).last }.join
			o << '   ' + (0...@cols).to_a.map { |i| i % 10 == 0 ? i.to_s.split(//).first : ' ' }.join
			o.join "\n"
		end

		private

			def read_file
				@raw = File.read @map_file
				matches = @raw.match /^(-{3}.*?)(?=-{3})/m
				@settings = YAML.load( matches[1] ) if matches && matches[1]
			end

			def parse_data
				@raw.split("\n").each do |line|
					matches = line.match /^[ 0-9]?\*([ xS]+)\*$/
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
