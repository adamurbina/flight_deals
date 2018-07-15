require "nokogiri"
require "open-uri"

class Scraper

    attr_accessor :deals

    def self.city_scraper(city_name)
        doc = Nokogiri::HTML(open("https://www.theflightdeal.com/category/flight-deals/#{city_name}/"))
        deals = doc.css(".entry-content")
        deals.collect do |deal|
            new_hash = {}
            new_hash[:title] = deal.css(".post-title").css("a").text
            new_hash[:description] = deal.css("p").text
            new_hash[:deal_url] = deal.css("a").attribute("href").value
            new_hash
        end
        #titles = doc.css(".post-title").css("a").text
        #description = deals.css("p").text

    end

    def self.deal_scraper(deal_url)

    end

end

puts Scraper.new.city_scraper("dc")
