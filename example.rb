require 'pp'
require_relative 'highway'

map_name = ARGV.shift || 'maps/map1.txt'
position = ( ARGV.shift || '11,29' ).split(',').map { |i| i.to_i }

map = Highway::Map.new map_name
#puts map.paint
canvas = Highway::Canvas.new map
car = Highway::Car.new
car.canvas = canvas
canvas.car = car
road = Highway::Road.new
road.init_pieces canvas
canvas.place_pieces road.pieces

game = Highway::Game.new do |g|
	g.canvas = canvas
	g.road = road
	g.car = car
end

game.start_at position
game.start
