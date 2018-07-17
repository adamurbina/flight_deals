class Deals
    attr_accessor :title, :description, :url, :availability

    @@all = []

    def initialize
        @@all << self
    end

    def self.all
        @@all
    end

    def open
        system("open #{@url}")
    end

end
