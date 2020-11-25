require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)
    students = Nokogiri::HTML(open(index_url))
    student_array = []
    students.css(".student-card").each do |s|
      this_hash = Hash.new(0)
      this_hash[:location] = s.css("p").text
      this_hash[:name] = s.css("h4").text
      this_hash[:profile_url] = s.css("a").first["href"]
      student_array << this_hash
    end
    student_array
  end


  def self.scrape_profile_page(profile_url)
    # attr :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url
    # binding.pry
    profile = Nokogiri::HTML(open(profile_url))
    student_details = Hash.new(0)
    student_details[:name] = profile.css(".profile-name").text
    student_details[:location] = profile.css(".profile-location").text
    student_details[:twitter] = profile.css("a").first["href"]
    student_details[:linkedin]
    student_details[:github]
    student_details[:blog]
    student_details[:profile_quote]
    student_details[:bio]
    student_details[:profile_url]

    page.css(ul.details.none li div a)
    #return hash {}  of attributes describing a single student based on their profile_url
    #student = {
    # :attribute1 => value;
    # :attribute2 => value;
# }
student_details

  end

end
