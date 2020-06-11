require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html=open(index_url)
    doc=Nokogiri::HTML(html)
    students=doc.css(".student-card")

    a=students.map do |student|
      hash={}
      hash[:name]=student.css(".student-name").text
      hash[:location]=student.css(".student-location").text
      hash[:profile_url]=student.css("a").attribute("href").value
      hash
    end
 end
 # # => [
 #        {:name => "Abby Smith", :location => "Brooklyn, NY", :profile_url => "students/abby-smith.html"},
 #        {:name => "Joe Jones", :location => "Paris, France", :profile_url => "students/joe-jonas.html"},
 #        {:name => "Carlos Rodriguez", :location => "New York, NY", :profile_url => "students/carlos-rodriguez.html"},
 #        {:name => "Lorenzo Oro", :location => "Los Angeles, CA", :profile_url => "students/lorenzo-oro.html"},
 #        {:name => "Marisa Royer", :location => "Tampa, FL", :profile_url => "students/marisa-royer.html"}
 #      ]

#  {
#   :twitter=>"http://twitter.com/flatironschool",
#   :linkedin=>"https://www.linkedin.com/in/flatironschool",
#   :github=>"https://github.com/learn-co",
#   :blog=>"http://flatironschool.com",
#   :profile_quote=>doc.css(".profile-quote").text=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
#   :bio=> doc.css(".description-holder p").text=>"I'm a school"
# }
#doc.css(".social-icon-container a")=>return a list of node
#doc.css(".social-icon-container a")[0].attribute("href").value=>link



 def self.scrape_profile_page(profile_url)
   html=open(profile_url)
   doc=Nokogiri::HTML(html)

   student_profile={}
   doc.css(".social-icon-container a").each do |social_media_node|
     value=social_media_node.attribute("href").value
     if (value.scan /https:\/\/(www\.)?(\w+)\.*/)==[]
       key="blog"
     else
       key=(value.scan /https:\/\/(www\.)?(\w+)\.*/)[0][-1]
     end
     student_profile[key.to_sym]=value
   end
   student_profile[:bio]=doc.css(".description-holder p").text
   student_profile[:profile_quote]=doc.css(".profile-quote").text
   student_profile

  end
end

#  def self.scrape_profile_page(profile_slug)
#     student = {}
#     profile_page = Nokogiri::HTML(open(profile_slug))
#     links = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
#     links.each do |link|
#       if link.include?("linkedin")
#         student[:linkedin] = link
#       elsif link.include?("github")
#         student[:github] = link
#       elsif link.include?("twitter")
#         student[:twitter] = link
#       else
#         student[:blog] = link
#       end
#     end
#
#     student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
#     student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")
#
# student
