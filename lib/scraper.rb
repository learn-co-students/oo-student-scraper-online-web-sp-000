require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  def self.scrape_index_page(index_url)
    url = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
    index_url = url.css(".student-card")
    index_url.map do |index|
    index_hash = {:name => index.css('h4').text.strip, :location => index.css('p').text.strip, :profile_url => index.css('a').attribute('href').value}
    index_hash
    end
   #binding.pry
  end

    #<a href="students/eric-chu.html">
    #index_url.css('a')
  def self.scrape_profile_page(profile_url)

  end

  #twitter
  #<a href="https://twitter.com/osmentdan"><img class="social-icon" src="../assets/img/twitter-icon.png"></a>
  #linkedin
  #<a href="http://www.linkedin.com/in/danosment"><img class="social-icon" src="../assets/img/linkedin-icon.png"></a>
  #github
  #<a href="http://www.github.com/Tsundu"><img class="social-icon" src="../assets/img/github-icon.png"></a>
  #blog
  #
  #profile quote
  #<div class="profile-quote">Student at Learn</div>
  #bio
  #<div class="description-holder">
    #<p>Entered US Navy after High School as an Electronics Technician.</p>
    #</div>

end
