class FlightDeals::CLI
    attr_reader :CITIES

    CITIES = ["NEW YORK CITY", "SAN FRANCISCO", "LOS ANGELES", "BOSTON", "CHICAGO", "DALLAS", "MIAMI", "PHILLY", "PHOENIX", "PORTLAND", "SEATTLE", "DC"]
    URL_LOOKUP = {"NEW YORK CITY" => "nyc", "SAN FRANCISCO" => "sfo", "LOS ANGELES" => "lax", "BOSTON" => "boston-flight-deals", "CHICAGO" => "chicago", "DALLAS" => "dallas", "MIAMI" => "miami", "PHILLY" => "philadelphia", "PHOENIX" => "phoenix", "PORTLAND" => "portland", "SEATTLE" => "seattle-flight-deals", "DC" => "dc"}

    def start
        welcome
        display_cities
        display_deals
        get_deals
    end

    def welcome
        puts "------------------------------------"
        puts "     Welcome to Flight Deals!"
        puts "------------------------------------"
    end

    def display_cities
        CITIES.each.with_index(1) do |city, index|
            puts "#{index} >> #{city}"
        end
        puts "Enter city number to get deals:"
    end

    def display_deals
        input = gets.chomp
        if (1..CITIES.size).include?(input.to_i)
            puts "Showing #{CITIES[(input.to_i)-1]} deals >>>"
            deals = Scraper.city_scraper(URL_LOOKUP[CITIES[(input.to_i) - 1]])
            deals.each.with_index(1) do |deal, i|
                puts "#{i} >> #{deal[:title]}"
            end
        elsif input == "exit"
            puts "Goodbye see you next time!"
            exit
        else
            puts "Input invalid. Please try again..."
            get_deals
        end
    end

    def get_deals
        puts "Select deal for more information or 'back' to go back."
        input = gets.chomp
        if input == "back"
            start
        elsif (1..CITIES.size).include?(input.to_i)
            puts "REACHED!"
        end
    end

end
