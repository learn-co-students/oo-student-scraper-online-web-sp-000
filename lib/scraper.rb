require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
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
    social = doc.css("div.social-icon-container a").collect {|icon| icon}
    social .each do
      binding.pry
      if icon.include?(twitter)
        student[:twitter] = doc.css("div.social-icon-container > a:nth-child(1)").attribute("href").value
      elsif icon.include?(linkedin)
        student[:linkedin] =doc.css("div.social-icon-container > a:nth-child(2)").attribute("href").value
      elsif icon.include?(github)
        student[:github] =doc.css("div.social-icon-container > a:nth-child(3)").attribute("href").value
      elsif icon.include?(blog)
        student[:blog] =doc.css("div.social-icon-container > a:nth-child(4)").attribute("href").value
      end
    end
      student[:profile_quote] = doc.css("body > div > div.vitals-container > div.vitals-text-container > div").inner_text.strip
      student[:bio] = doc.css("body > div > div.details-container > div.bio-block.details-block > div > div.description-holder > p").inner_text
  end
end
