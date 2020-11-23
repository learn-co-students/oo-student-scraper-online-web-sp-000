require 'nokogiri'
require 'open-uri'
require 'pry'

#doc.css('.div.student-card')
#name  student.css('h4.student-name')
#location student.css('p.student-location')
#profile_url student.css('a').attribute('href').value

class Scraper

  def self.scrape_index_page(index_url)
    array = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css('div.student-card').each do |student|
    array << {:name => student.css('h4.student-name').text,
              :location => student.css('p.student-location').text,
              :profile_url => student.css('a').attribute('href').value}
    end
    array
    #binding.pry
  end

#base = doc.css('div.main-wrapper.profile')
#base.css('div.social-icon-container')

  def self.scrape_profile_page(profile_url)
    hash = {}
    doc = Nokogiri::HTML(open(profile_url))
    #binding.pry
    base = doc.css('div.social-icon-container a')
    base.each do |social|
      if social.attribute('href').value.include? "twitter" #== "https://twitter.com/empireofryan"
        hash[:twitter] = social.attribute('href').value
      elsif social.attribute('href').value.include? "linkedin"#.end_with?("ab") #== "https://www.linkedin.com/in/ryan-johnson-321629ab"
        hash[:linkedin] = social.attribute('href').value
      elsif social.attribute('href').value.include? "github" #== "https://github.com/empireofryan"
        hash[:github] = social.attribute('href').value
      elsif social.attribute('href').value.end_with?("com/")# == "".match(/com/)
        hash[:blog] = social.attribute('href').value #|| hash[:blog] = "N/A"
      end
    end
    hash[:profile_quote] = doc.css('div.profile-quote').text
    hash[:bio] = doc.css('p').text
    hash
  #binding.pry
  end

end

Scraper.scrape_profile_page("https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html")
