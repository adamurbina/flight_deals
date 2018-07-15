class Deals
    attr_accessor :title, :description, :url, :availability
    
    @@all = []

    def initialize
        @@all << self
    end

    def self.all
        @@all
    end

end
