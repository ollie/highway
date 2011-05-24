require 'pp'
require 'trollop'
require_relative 'highway'

opts = Trollop.options do
	opt :map, 'Which map to load? Defaults to map/001.txt.', :short => :m, :type => String, :default => 'maps/001.txt'
	opt :pos, 'Start at which position? For example "19,29" starts at row 19 column 29.', :short => :p, :type => String, :default => '19,29'
end

map = Highway::Map.new opts[:map]
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

game.start_at opts[:pos]
game.start
