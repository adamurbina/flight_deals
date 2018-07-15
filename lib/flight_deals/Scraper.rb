require "nokogiri"
require "open-uri"

class Scraper

    def self.city_scraper(city)
        doc = Nokogiri::HTML(open("https://www.theflightdeal.com/category/flight-deals/#{city.url_ext}/"))
        deals_html = doc.css(".entry-content")
        deals_html.collect do |deal|
            new_deal = Deals.new
            new_deal.title = deal.css(".post-title").css("a").text
            new_deal.description = deal.css("p").text
            new_deal.url = deal.css("a").attribute("href").value
            city.add_deal(new_deal)
            new_deal
        end
    end

    def self.deal_scraper(deal)
        doc = Nokogiri::HTML(open(deal.url))
        availability = doc.css(".entry-content").css("ul")[2].css("li").text
        #description = doc.css(".entry-content").css("a")[0].text
        deal.availability = availability
    end

end

# puts Scraper.deal_scraper("https://www.theflightdeal.com/2018/07/15/jetblue-134-boston-minneapolis-and-vice-versa-roundtrip-including-all-taxes/")
