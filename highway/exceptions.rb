module Highway
  class NoFuelException < Exception
    def message
      "You cannot drive without fuel!"
    end
  end

  class NoRoadException < Exception
    def initialize( meth = nil )
      @meth = meth
    end

    def message
      if @meth
        "You cannot go #{ @meth.capitalize }!"
      end
    end
  end
end