require 'highline/system_extensions'
include HighLine::SystemExtensions

module Highway
	class Game
		attr_accessor :canvas, :road, :car

		def initialize
			yield self if block_given?
		end

		def start_at( coords )
			@car.drive_on @road.piece_at coords
		rescue NoRoadException => e
			system 'clear'
			possible_road = @road.pieces.find_all do |i|
				i.coords.north == coords ||
				i.coords.east == coords ||
				i.coords.south == coords ||
				i.coords.west == coords
			end
			puts @canvas.map.paint
			puts "There is no road at #{ coords }."
			if possible_road.size > 1
				puts "Did you mean one of those #{ possible_road.map { |i| i.coords.to_s }.join ', ' }?"
			elsif possible_road.size == 1
				puts "Did you mean one #{ possible_road.to_s }?"
			else
				puts "And there is no road around, so here is the list of all pieces."
				puts @road.pieces.map { |i| i.coords.to_s }.join ', '
			end
			exit
		end

		def start
			@car.max_fuel
			#@canvas.delay = 0.1
			@canvas.draw
			#@car.drive_around
			#@car.drive_around_short
			drive
		end

		private

			def drive
				catch :quit do
					loop do
						print "Which way to go? [wsadq]: "
						ch = get_character.chr
						unless ch.match /^[aswdq]$/
							puts
							next
						end
						throw :quit if ch == 'q'
						@car.send ch
					end
				end
				puts
			end
	end
end
