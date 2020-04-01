require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = (open(index_url))
    doc = Nokogiri::HTML(html)
    student_data = []
    doc.css("div.student-card").each do |student|
      student_data << {:name => student.css("h4.student-name").text, :location => student.css("p.student-location").text, :profile_url => student.css("a").attribute("href").value}
    end
    student_data
  end

  def self.scrape_profile_page(profile_url)
    html = (open(profile_url))
    doc = Nokogiri::HTML(html)
    student_info = {}
    social_links = doc.css("div.social-icon-container a")
    social_links.each do |data|
      link = data.attribute("href").value
      if link =~ /.+twitter.com.+/
        student_info[:twitter] = link
        elsif link =~ /.+linkedin.com.+/
        student_info[:linkedin] = link
        elsif link =~ /.+github.com.+/
        student_info[:github] = link
      else
        student_info[:blog] = link
      end
    end
    student_info[:profile_quote] = doc.css("div.profile-quote").text
    student_info[:bio] = doc.css("div.bio-content p").text
    student_info
  end

end

