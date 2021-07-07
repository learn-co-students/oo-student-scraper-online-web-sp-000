require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    page = Nokogiri::HTML(open(index_url))

    section = page.css("div.student-card")

    section.collect do |item|
      student_hash = {:name => item.css("h4.student-name").text,
                      :location => item.css("p.student-location").text,
                      :profile_url => item.css("a").attribute("href").value}
      students << student_hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = {}
    page = Nokogiri::HTML(open(profile_url))
    social = page.css("div.social-icon-container a")

     social.each do |item|
      case item.attribute('href').value
        when /twitter/
        profile[:twitter] = item.attribute('href').value

         when /linkedin/
        profile[:linkedin] = item.attribute('href').value

         when /github/
        profile[:github] = item.attribute('href').value

         else
        profile[:blog] = item.attribute('href').value

         end
      end

       profile[:profile_quote] = page.css("div.vitals-text-container").css(".profile-quote").text
       profile[:bio] = page.css("div.description-holder").css("p").text

       profile
     end

end
