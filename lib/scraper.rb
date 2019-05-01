require 'open-uri'
require 'pry'



class Scraper

  def self.scrape_index_page(index_url)
    index = open(index_url)
    doc = Nokogiri::HTML((index))
    binding.pry
    new_array = []
    new_array << doc.css('body','div#main-wrapper roster div#roster-cards-container')
    binding.pry
    # open(index_url, :name => //div/a, :location => "location", :profile_url=>"students/name"){|f|
    # }

  end

  def self.scrape_profile_page(profile_url)


  end

end
