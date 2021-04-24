require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))

    students = []

    index_page.css("div.student-card").each do |student|
      students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attr("href").value
      }
    #h4 class="student-name"
    #p class="student-location"
    #a href
  end
  students
end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))

    student = {}

    links = profile_page.css("div.social-icon-container").css("a").collect {|s| s.attribute("href").value}

    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
    end
    student[:bio] = profile_page.css(".description-holder").css("p").text
    student[:profile_quote] = profile_page.css(".profile-quote").text
    student
  end

end
