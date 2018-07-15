require "nokogiri"
require "open-uri"

class Scraper

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

    end

    def self.deal_scraper(deal_url)
        doc = Nokogiri::HTML(open(deal_url))
        availability = doc.css(".entry-content").css("ul")[2].css("li").text
        description = doc.css(".entry-content").css("a")[0].text
        url = deal_url
    end

end

puts Scraper.deal_scraper("https://www.theflightdeal.com/2018/07/15/jetblue-134-boston-minneapolis-and-vice-versa-roundtrip-including-all-taxes/")
