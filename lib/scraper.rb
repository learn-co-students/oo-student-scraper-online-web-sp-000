require 'open-uri'
require 'pry'

# student body: student.css("div.student-card").first
#name: person.css("div.card-text-container h4.student-name").text
#location: person.css("div.card-text-container p.student-location").text
#url: person.css("a")[0]['href']


class Scraper
  
  def self.scrape_index_page(index_url)
    students = []
    Nokogiri::HTML(open(index_url)).css("div.student-card").each do |person|
      students << {
        :name => person.css("div.card-text-container h4.student-name").text, 
        :location => person.css("div.card-text-container p.student-location").text, 
        :profile_url => person.css("a")[0]['href']} 
    end
    students
     
  end

  def self.scrape_profile_page(profile_url)
    
    student_info = {}
    
    Nokogiri::HTML(open(profile_url)).css("div.social-icon-container a"). each do |site|
      if site['href'].include?'twitter'
        student_info[:twitter] = site['href']
      elsif site['href'].include?'linkedin'
        student_info[:linkedin] = site['href']
      elsif site['href'].include?'github'
        student_info[:github] = site['href']
      else 
        student_info[:blog] = site['href']
      end
    end
    
    student_info[:profile_quote] = Nokogiri::HTML(open(profile_url)).css("div.vitals-text-container div.profile-quote").text.strip
    student_info[:bio] = Nokogiri::HTML(open(profile_url)).css("div.description-holder p").text.strip
    
    student_info
  end

end

      # :twitter => Nokogiri::HTML(open(profile_url)).css("div.social-icon-container a")[0]['href'],
      # :linkedin => Nokogiri::HTML(open(profile_url)).css("div.social-icon-container a")[1]['href'],
      # :github => Nokogiri::HTML(open(profile_url)).css("div.social-icon-container a")[2]['href'],
      # :blog => Nokogiri::HTML(open(profile_url)).css("div.social-icon-container a")[3]['href'],
