require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = []
    doc.css(".student-card").each do |page|
        students << {
        :name => page.css(".student-name").text,
        :profile_url => page.css("a").attr('href').value,
        :location => page.css(".student-location").text
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    page = Nokogiri::HTML(html)
    #page = doc.css(".social-icon-container a")
    social = {}
    container = page.css(".social-icon-container a").collect{|icon| icon.attribute("href").value}
      container.each do |link|
        if link.include?("twitter")
          social[:twitter] = link
        elsif link.include?("linkedin")
          social[:linkedin] = link
        elsif link.include?("github")
          social[:github] = link
        elsif link.include?(".com")
          social[:blog] = link
        end
      end
      social[:profile_quote] = page.css(".profile-quote").text
      social[:bio] = page.css("div.description-holder p").text
      social
    #page.collect do |icon|
      #icon.attribute("href").value.each do |profile|
      #if profile.css("a").attr("href").value.include?("twitter")
      #  social[:twitter] = profile.css("a").attr("href").value
      #elsif profile.css("a").attr("href").value.include?("linkedin")
      #  social[:linkedin] = profile.css("a").attr("href").value
      #elsif profile.css("a").attr("href").value.include?("github")
      #  social[:github] = profile.css("a").attr("href").value
      #elsif profile.css("a").attr("href").value.end_with?("com/")
        #social[:blog] = profile.css("a").attr("href")
      #end
      #end
      #social[:profile_quote] = doc.css(".vitals-container .vitals-text-container .profile-quote").text
      #social[:bio] = doc.css(".details-container .description-holder p").text
    #end
    #social
    #binding.pry
  end

end
