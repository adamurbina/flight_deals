class CLI

    URL_LOOKUP = {"NEW YORK CITY" => "nyc", "SAN FRANCISCO" => "sfo", "LOS ANGELES" => "lax", "BOSTON" => "boston-flight-deals", "CHICAGO" => "chicago", "DALLAS" => "dallas", "MIAMI" => "miami", "PHILLY" => "philadelphia", "PHOENIX" => "phoenix", "PORTLAND" => "portland", "SEATTLE" => "seattle-flight-deals", "DC" => "dc"}

    def start
        welcome
        load_cities
        main_loop
    end

    def main_loop
        display_cities
        city = choose_city
        while true
            display_deals(city)
            deal = choose_deal(city)
            get_deal_details(deal)
            choose_next(deal)
        end

    end

    def welcome
        puts "------------------------------------"
        puts "     Welcome to Flight Deals!"
        puts "------------------------------------"
    end

    def load_cities
        URL_LOOKUP.each do |city_name, city_url|
            new_city = City.new(city_name)
            new_city.url_ext = city_url
        end
    end

    def display_cities
        URL_LOOKUP.sort.each_with_index do |(city_name, city_url), index|
            puts "#{index + 1} >> #{city_name}"
        end
    end

    def choose_city
        puts "Enter city number to get deals"
        input = gets.chomp
        if (1..URL_LOOKUP.size).include?(input.to_i)
            selected_city = URL_LOOKUP.sort[(input.to_i)-1][0]
            city = City.all.detect{|city| city.name == selected_city}
            return city
        elsif input == "exit"
            goodbye
        else
            puts "Input invalid. Please try again..."
            choose_city
        end
    end

    def display_deals(city)
        if city.deals == []
            puts "Loading #{city.name} deals"
            Scraper.city_scraper(city)
        end

        puts "Showing #{city.name} deals >>>"
        city.deals.each.with_index(1) do |deal, index|
        puts "#{index} >> #{deal.title}"
    end

    def choose_deal(city)
        puts ""
        puts "Select deal for more information or 'back' to go back."
        input = gets.chomp
        if input == "back"
            main_loop
        elsif input == "exit"
            goodbye
        elsif (1..city.deal_count).include?(input.to_i)
            deal = city.deals[(input.to_i) - 1]
            return deal
        else
            puts "Entry invalid. Please try again."
            choose_deal(city)
        end
    end

    def get_deal_details(deal)
        if !deal.availability
            puts "Loading deal..."
            Scraper.deal_scraper(deal)
        end

        puts "DEAL:          #{deal.title}"
        puts "DESCRIPTION:   #{deal.description}"
        puts "AVAILABILITY:  #{deal.availability}"
        puts "WEBSITE:       #{deal.url}"
        puts ""
        end
    end

    def choose_next(deal)
        puts "What would you like to do next?"
        puts "Enter 'open' to open the website, enter 'back' to go back to deal list, 'cities' to go back to city list, and 'exit' to quit."

        input = gets.chomp

        if input == "cities"
            main_loop
        elsif input == "open"
            deal.open
            choose_next(deal)
        elsif input == 'exit'
            goodbye
        end
    end

    def goodbye
        puts "Goodbye! See you next time!"
        exit
    end

end
