class FlightDeals::CLI

    CITIES = ["NYC", "SF", "LA", "BOSTON", "CHICAGO", "DALLAS", "MIAMI", "PHILLY", "PHOENIX", "PORTLAND", "SEATTLE", "DC"]

    def start
        puts "Welcome to the finding Daily Deals!"
        display_cities
        get_deals
    end

    def display_cities
        CITIES.each_with_index do |city, index|
            puts "#{index + 1}: #{city}"
        end
        puts "Enter city number to get deals:"
    end

    def get_deals
        input = gets.chomp
        while input != "exit" && (1..CITIES.size).include?(input.to_i)
            puts "interior reached"
        end
        puts "good bye"
    end



end
