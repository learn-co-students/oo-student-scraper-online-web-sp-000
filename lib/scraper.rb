require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    index_list = Nokogiri::HTML(html)
    student_array = []
    counter = 0
    index_list.css('div.student-card').each do |student|
      student_array << {
      :name => student.css('div.card-text-container').css('h4').text,
      :location => student.css('div.card-text-container').css('p').text,
      :profile_url => student.css('a').attribute('href').value
    }
    end
    student_array
  end


  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile = Nokogiri::HTML(html)
    social = []
    profile.css('div.social-icon-container').css('a').each do |site|
      social << site.attribute('href').value
    end
    hash = {
      :profile_quote => profile.css('div.profile-quote').text,
      :bio => profile.css('div.bio-content.content-holder').css('p').text
    }
    social.each do |site|
      if site[/twitter/]
        hash[:twitter] = site
      elsif site[/github/]
        hash[:github] = site
      elsif site[/linkedin/]
        hash[:linkedin] = site
      elsif site[/facebook/]
      else
        hash[:blog] = site
      end
    end
    hash
  end
end
