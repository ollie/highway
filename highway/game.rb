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
			puts "There is no road at #{ coords }!"
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
