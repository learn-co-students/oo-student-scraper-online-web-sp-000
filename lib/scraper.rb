require 'open-uri'
require 'pry'

class Scraper
  # KEYS FOR HASHES ARE :NAME, :LOCATION, :PROFILE_URL
  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

scrape_profile_page('https://learn-co-curriculum.github.io/student-scraper-test-page/index.html')

