require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.student-card").each do |s|
      name = s.css(".student-name").text
      location = s.css(".student-location").text
      profile_url = s.css("a").attribute("href").value
      student_obj = {:name => name, :location => location, :profile_url => profile_url}
      students << student_obj
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile = {}

    links = doc.css(".social-icon-container a").collect {|i| i.attribute("href").value}
    links.each do |l|
      if l.include?("twitter")
        profile[:twitter] = l
      elsif l.include?("github")
        profile[:github] = l
      elsif l.include?("linkedin")
        profile[:linkedin] = l
      elsif l.include?(".com")
        profile[:blog] = l
      end
    end
    profile[:profile_quote] = doc.css("div.profile-quote").text
    profile[:bio] = doc.css("div.description-holder p").text
    return profile
  end



end

#URL:  http://159.89.134.39:53825/fixtures/student-site/
# http://159.89.134.39:53825/fixtures/student-site/students/ryan-johnson.html
# [
#   {:name => "Abby Smith", :location => "Brooklyn, NY", :profile_url => "students/abby-smith.html"},
#   {:name => "Joe Jones", :location => "Paris, France", :profile_url => "students/joe-jonas.html"},
#   {:name => "Carlos Rodriguez", :location => "New York, NY", :profile_url => "students/carlos-rodriguez.html"},
#   {:name => "Lorenzo Oro", :location => "Los Angeles, CA", :profile_url => "students/lorenzo-oro.html"},
#   {:name => "Marisa Royer", :location => "Tampa, FL", :profile_url => "students/marisa-royer.html"}
# ]

# :linkedin=>"https://www.linkedin.com/in/flatironschool",
# :github=>"https://github.com/learn-co,
# :blog=>"http://flatironschool.com",
# :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
# :bio=> "I'm a school"
# }
