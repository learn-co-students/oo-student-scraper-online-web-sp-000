require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_index_array = []
      html = open("#{index_url}")
      data = Nokogiri::HTML(html).css('div.roster-cards-container')
      data.css('a').collect do |l|
        student_hash = {}
        student_hash[:name] = l.css('h4').text
        student_hash[:location] = l.css('p').text
        student_hash[:profile_url] = "#{l['href']}"
        student_index_array << student_hash
      end
      student_index_array
  end

  def self.scrape_profile_page(profile_url)
    student_hash = {}
    result = ""
      html = open("#{profile_url}")
      data = Nokogiri::HTML(html).css('div.social-icon-container').css('a')

      data.collect do |l|
        result = l.attributes['href'].text
        if result.include?('twitter') then student_hash[:twitter] = result
        elsif result.include?('linked') then student_hash[:linkedin] = result
        elsif result.include?('git') then student_hash[:github] = result
        else
          student_hash[:blog] = result
        end
      end

      html = open("#{profile_url}")
        student_hash[:bio] = Nokogiri::HTML(html).css('div.description-holder').first.children[1].text
      html = open("#{profile_url}")
        student_hash[:profile_quote] = Nokogiri::HTML(html).css('div.profile-quote').text
    student_hash
  end

end
