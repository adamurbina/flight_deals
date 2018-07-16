class CLI

    CITIES = ["NEW YORK CITY", "SAN FRANCISCO", "LOS ANGELES", "BOSTON", "CHICAGO", "DALLAS", "MIAMI", "PHILLY", "PHOENIX", "PORTLAND", "SEATTLE", "DC"]
    URL_LOOKUP = {"NEW YORK CITY" => "nyc", "SAN FRANCISCO" => "sfo", "LOS ANGELES" => "lax", "BOSTON" => "boston-flight-deals", "CHICAGO" => "chicago", "DALLAS" => "dallas", "MIAMI" => "miami", "PHILLY" => "philadelphia", "PHOENIX" => "phoenix", "PORTLAND" => "portland", "SEATTLE" => "seattle-flight-deals", "DC" => "dc"}

    def start
        welcome
        load_cities
        main_loop
    end

    def main_loop
        display_cities
        city = choose_city
        display_deals(city)
        #get_deal_details(city)
    end

    def welcome
        puts "------------------------------------"
        puts "     Welcome to Flight Deals!"
        puts "------------------------------------"
    end

    def load_cities
        URL_LOOKUP.each do |key, value|
            new_city = City.new(key)
            new_city.url_ext = value
        end
    end

    def display_cities
        CITIES.each.with_index(1) do |city, index|
            puts "#{index} >> #{city}"
        end
    end

    def choose_city
        puts "Enter city number to get deals"
        input = gets.chomp
        if (1..CITIES.size).include?(input.to_i)
            selected_city = CITIES[(input.to_i)-1]
            city = City.all.detect{|city| city.name == selected_city}
            return city
        elsif input == "exit"
            puts "Goodbye see you next time!"
            exit
        else
            puts "Input invalid. Please try again..."
            choose_city
        end
    end

    def display_deals(city)
        if city.deals == []
            Scraper.city_scraper(city)
            puts "Loading #{city.name} deals"
        end

        puts "Showing #{city.name} deals >>>"
        city.deals.each.with_index(1) do |deal, i|
        puts "#{i} >> #{deal.title}"
    end

    def choose_details(city)
        puts "Select deal for more information or 'back' to go back."
        input = gets.chomp
    end

    def get_deal_details(city)

        if input == "back"
            main_loop
        elsif input == "exit"
            "Goodbye"
            exit
        elsif (1..city.deal_count).include?(input.to_i)
            deal = city.deals[(input.to_i) - 1]
            Scraper.deal_scraper(deal)
            puts "DEAL:          #{deal.title}"
            puts "DESCRIPTION:   #{deal.description}"
            puts "AVAILABILITY:  #{deal.availability}"
            puts "WEBSITE:       #{deal.url}"
            puts ""

        else
            puts "Entry invalid. Please try again."
            get_deals
        end
    end

end
