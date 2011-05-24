autoload :YAML,					'yaml'

module Highway
	autoload :Array,			'./highway/core_ext/array'
	autoload :Game,				'./highway/game'
	autoload :Road,				'./highway/road'
	autoload :Car,				'./highway/car'
	autoload :Piece,			'./highway/piece'
	autoload :Canvas,			'./highway/canvas'
	autoload :Map,				'./highway/map'
	autoload :NoFuelException,	'./highway/exceptions'
	autoload :NoRoadException,	'./highway/exceptions'
end