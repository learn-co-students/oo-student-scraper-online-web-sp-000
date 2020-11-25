require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")
    students.map do |student|
      {
        name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: student.css("a").attribute("href").value
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    social_media = doc.css(".social-icon-container")
    urls = social_media.css("a[href]").map {|e| e['href']}
    pq = doc.css(".profile-quote").text
    bio = doc.css(".description-holder p").text
    blog = doc.css(".profile-name").text.downcase.split
    hash = {profile_quote: pq, bio: bio}
    urls.each do |url| 
      hash[:twitter] = url if url.match(/twitter/)
      hash[:linkedin] = url if url.match(/linkedin/)
      hash[:github] = url if url.match(/github/)
      #if url.include? "#{blog[0]}" && url.include? "#{blog[1]}"
      hash[:blog] = url if url.include? "http://#{blog[0]}"
    end
    hash
  end

end

