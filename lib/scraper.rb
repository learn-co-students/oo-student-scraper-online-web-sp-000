require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_list = []
    students = doc.css("div.student-card")

    students.each do |student|
      name =  student.css("h4.student-name").text.strip
      location = student.css("p.student-location").text.strip
      profile_url =student.css("a").attribute("href").value
      student_list<<{:name => name, :location => location, :profile_url => profile_url}
    end
    student_list
  end

  def self.scrape_profile_page(profile_url)
    student = {}

    doc = Nokogiri::HTML(open(profile_url))
    social = doc.css("div.social-icon-container a").collect {|icon| icon.attribute("href").value}
    social.each.with_index(1) do |link, i|

      if link.include?("twitter.com")
        student[:twitter] = doc.css("div.social-icon-container > a:nth-child(#{i})").attribute("href").value
      elsif link.include?("linkedin.com")
        student[:linkedin] =doc.css("div.social-icon-container > a:nth-child(#{i})").attribute("href").value
      elsif link.include?("github.com")
        student[:github] =doc.css("div.social-icon-container > a:nth-child(#{i})").attribute("href").value
      elsif link.include?(".com")
        student[:blog] =doc.css("div.social-icon-container > a:nth-child(#{i})").attribute("href").value
      end
    end
      student[:profile_quote] = doc.css("div.vitals-text-container > div").inner_text.strip
      student[:bio] = doc.css("div.description-holder > p").inner_text
      student
  end
end
