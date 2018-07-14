class FlightDeals::CLI
    attr_reader :CITIES

    CITIES = ["NEW YORK CITY", "SAN FRANCISCO", "LOS ANGELES", "BOSTON", "CHICAGO", "DALLAS", "MIAMI", "PHILLY", "PHOENIX", "PORTLAND", "SEATTLE", "DC"]
    URL_LOOKUP = {"NEW YORK CITY" => "nyc", "SAN FRANCISCO" => "sfo", "LOS ANGELES" => "lax", "BOSTON" => "boston-flight-deals", "CHICAGO" => "chicago", "DALLAS" => "dallas", "MIAMI" => "miami", "PHILLY" => "philadelphia", "PHOENIX" => "phoenix", "PORTLAND" => "portland", "SEATTLE" => "seattle-flight-deals", "DC" => "dc"}

    def start
        puts "Welcome to the finding Daily Deals!"
        display_cities
        get_deals
    end

    def display_cities
        CITIES.each_with_index do |city, index|
            puts "#{index + 1} >> #{city}"
        end
        puts "Enter city number to get deals:"
    end

    def get_deals
        input = gets.chomp
        if (1..CITIES.size).include?(input.to_i)
            #puts "url is #{URL_LOOKUP[CITIES[(input.to_i) - 1]]} "
        elsif input == "exit"
            puts "Goodbye see you next time!"
            exit
        else
            puts "Input invalid. Please try again..."
            get_deals
        end
    end



end
