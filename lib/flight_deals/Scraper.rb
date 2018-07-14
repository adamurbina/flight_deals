class FlightDeals::CityDeals

    def scrape_city(city_name)
        doc = Nokogiri::HTML(open("https://www.theflightdeal.com/category/flight-deals/dc/"))
        titles = doc.css(".post-title").css("a").text
        description = doc.css(".entry-content").css("p").text
        puts description
    end

end
