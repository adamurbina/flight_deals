class Deals
    attr_reader :title, :description, :url, :availability
    @@all = []

    def initialize(title, description, url)
        @title = title
        @description = description
        @url = url
        @@all << self
    end

    def self.all
        @@all
    end

end
