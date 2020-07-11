require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/"))
    @student_array = []
    doc.css(".student-card").each do |x|
      @student_hash = {
        profile_url: x.css("a").attribute("href").value,
        name: x.css("h4").text.strip,
        location: x.css("p").text
      }
      @student_array << @student_hash
    end
    @student_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    @social_array = []
    @social_hash = {}
    doc.css(".social-icon-container").css("a").each do |x|
      soc = x.attribute("href").value
      @social_array << soc
    end
    @social_array.each do |x|
      if x.match(/github/)
        @social_hash[:github] = x
      elsif x.match(/twitter/)
        @social_hash[:twitter] = x
      elsif x.match(/linkedin/)
        @social_hash[:linkedin] = x
      else
        @social_hash[:blog] = x
      end
    end
    
    i = doc.css(".vitals-text-container").css("div.profile-quote").text
    @social_hash[:profile_quote] = i
    
    j = doc.css(".description-holder").css("p").text
    @social_hash[:bio] = j
    
    return @social_hash
  end
  

end

