module Highway
  class Piece
    attr_accessor :coords, :car, :north, :east, :south, :west
    attr_reader :station

    def initialize( coords )
      @coords = [ coords[:row], coords[:col] ]
      @station = coords[:station]
      yield self if block_given?
    end

    def method_missing( meth, *args, &block )
      case meth
      when /^w|north$/
        north
      when /^d|east$/
        east
      when /^s|south$/
        south
      when /^a|west$/
        west
      else
        super
      end
    end

    def row
      @coords.first
    end

    def col
      @coords.last
    end
  end
end
