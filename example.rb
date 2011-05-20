require 'pp'
require_relative 'highway'

map = Highway::Map.new 'map2.txt'
#puts map.paint
canvas = Highway::Canvas.new map
car = Highway::Car.new
road = Highway::Road.new
road.init_pieces canvas
canvas.place_pieces road.pieces

game = Highway::Game.new do |g|
	g.canvas = canvas
	g.road = road
	g.car = car
end

game.start_at [7, 16]
game.start
