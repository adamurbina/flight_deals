class City
    attr_accessor :deals, :name, :url_ext, :deal_count

    @@all = []

    def initialize(name)
        @name = name
        @deals = []
        @@all << self
    end

    def add_deal(deal)
        @deals << deal
    end

    def self.all
        @@all
    end

    def deal_count
        @deal_count = @deals.count
    end

end
