require 'open-uri'
require 'pry'

require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    profiles = []

    index = Nokogiri::HTML(open(index_url))

    index.css("div.roster-cards-container").each do |profile|
      profile.css("div.student-card a").each do |student|
        profile_link = student.attribute("href").value
        profile_location = student.css(".student-location").text
        profile_name = student.css(".student-name").text

        profiles << {name: profile_name, location: profile_location, profile_url: profile_link}
      end
    end
    profiles
  end


  def self.scrape_profile_page(profile_url)
    student = {}

    profile_page = Nokogiri::HTML(open(profile_url))

    profile_page.css("div.social-icon-container a").each do |social_sites|
      social_sites.attributes("href").each do |social|
        # binding.pry
        social
      end
    end
  end

  # => {:twitter=>"http://twitter.com/flatironschool",
      #   :linkedin=>"https://www.linkedin.com/in/flatironschool",
      #   :github=>"https://github.com/learn-co,
      #   :blog=>"http://flatironschool.com",
      #   :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
      #   :bio=> "I'm a school"
      #  }


end
