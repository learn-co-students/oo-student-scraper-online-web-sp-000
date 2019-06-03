require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('./fixtures/student-site/index.html')
    index_page = Nokogiri::HTML(html)

    students = []

    index_page.css("div.student-card").each do |student|
      name = student.css("h4.student-name").text
      location = student.css("p.student-location").text
      profile_url = student.css("a").attribute("href").value
      students << {:name => name, :location => location, :profile_url => profile_url}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile_page = Nokogiri::HTML(html)
    social_links = profile_page.css("div.social-icon-container").css("a").select {|social| social.attribute("href").value}
    binding.pry



  end

#  {{:twitter=>"https://twitter.com/jmburges",
#                            :linkedin=>"https://www.linkedin.com/in/jmburges",
#                            :github=>"https://github.com/jmburges",
#                            :blog=>"http://joemburgess.com/",
#                            :profile_quote=>"\"Reduce to a previously solved problem\"",
#                            :bio=>
#  "I grew up outside of the Washington DC (NoVA!) and went to college at Carnegie Mellon University in Pittsburgh. After college, I worked as an Oracle consultant for IBM for a bit and now I teach here at The Flatiron School."}}


end
