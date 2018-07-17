class Scraper

    def self.city_scraper(city)
        doc = Nokogiri::HTML(open("https://www.theflightdeal.com/category/flight-deals/#{city.url_ext}/"))
        deals_html = doc.css(".entry-content")
        deals_html.collect do |deal|
            new_deal = Deals.new
            title = deal.css(".post-title").css("a").text.split(" – ")
            new_deal.title = "#{title[1]} -> #{title[2]}"
            new_deal.description = deal.css("p").text
            new_deal.url = deal.css("a").attribute("href").value
            city.add_deal(new_deal)
            new_deal
        end
    end

    def self.deal_scraper(deal)
        doc = Nokogiri::HTML(open(deal.url))
        availability = doc.css(".entry-content").css("ul")[2].css("li").text
        deal.availability = availability
    end

end
