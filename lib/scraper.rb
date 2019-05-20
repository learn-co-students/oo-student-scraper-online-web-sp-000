require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = Nokogiri::HTML(open(index_url))
    doc = html.css(".student-card")
    doc.each do |student|
      hash = {
        :location => student.css(".student-location").text,
        :name => student.css(".student-name").text,
        :profile_url => student.css('a').attribute('href').value
      }
      students.push(hash)
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))
    links = html.css('.social-icon-container a').map { |link| link['href'] }
    hash = {
      :twitter=>links.select{|link| link.include?("twitter")}[0],
      :linkedin=>links.select{|link| link.include?("linkedin")}[0],
      :github=>links.select{|link| link.include?("github")}[0],
      :blog=>links[3],
      :profile_quote=>html.css(".profile-quote").text,
      :bio=> html.css("p").text
    }
    hash.delete_if {|key, value| value == nil}
  end
end
