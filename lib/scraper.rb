require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    student_index_array = []

    doc.css(".student-card").each do |student|
      student_index_array << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
    student_index_array
  end


  def self.scrape_profile_page(profile_url)
    
  end

end

=begin

[1] pry(Scraper)> student_index_array
=> [{:name=>"Kevin McCormack",
  :location=>"New York, NY",
  :profile_url=>"students/kevin-mccormack.html"}]


<div class="student-card" id="ryan-johnson-card">
 ->           <a href="students/ryan-johnson.html">
              <div class="view-profile-div">
                <h3 class="view-profile-text">View Profile</h3>
              </div>
              <div class="card-text-container">
 ->                <h4 class="student-name">Ryan Johnson</h4>
 ->                <p class="student-location">New York, NY</p>
              </div>
            </a>
          </div>

=end