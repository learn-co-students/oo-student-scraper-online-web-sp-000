require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  @@scraped_students = []
# <a href="students/ryan-johnson.html">
#               <div class="view-profile-div">
#                 <h3 class="view-profile-text">View Profile</h3>
#               </div>
#               <div class="card-text-container">
#                 <h4 class="student-name">Ryan Johnson</h4>
#                 <p class="student-location">New York, NY</p>
#               </div>
#             </a>


  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open('./fixtures/student-site/index.html'))
       
    html.css(".student-card").each do |student| 
      student_name = student.css(".student-name").text 
      #binding.pry
      student_name_url = student_name.split(" ").join("-").downcase
      student_location = student.css(".student-location").text
      student_profile = "students/#{student_name_url}.html"
      hash = {:name => student_name, :location => student_location, :profile_url => student_profile}
      @@scraped_students << hash 
    end 
      @@scraped_students
   
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

