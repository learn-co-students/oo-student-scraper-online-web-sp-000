require_relative '../config.rb'

#built to scrap the frozen URL provided by FI
class Scraper

  def self.scrape_index_page(index_url)
    parsed = []
    html = open(index_url)
    chunk = Nokogiri::HTML(html)
    students = chunk.css(".student-card")
    students.each do |student|
      name = student.css("h4.student-name").text
      location = student.css("p.student-location").text
      url = student.css("a").attribute("href").value
      parsed << {name: name, location: location, profile_url: url}
    end
    parsed
  end


#Leaving breadcrumbs for CLI/Final project later
#scraping info using NOKO into a hash syntax
#empty hash to store stuff
#grab text using Nokogiri
#parse profile_text and grab out social_details first
#add the quote to the hash under sym :profile_quote
#add bio same syntax
#conditionally able to navigate aroune attr if no socials
#if social_details present parses through and collects ea to hash
#ruby returns her last line always
#hash

    def self.scrape_profile_page(profile_url)
      profile_hash = {}
      #better var/name for profile? hmm...
      profile = Nokogiri::HTML(open(profile_url))
      socials = profile.css('.social-icon-container > a')
      profile_hash[:profile_quote] = profile.css(".profile-quote").text
      profile_hash[:bio] = profile.css("p").text
      if socials
        socials.each do |text|
          link = text.attr("href")
          if link.include?("twitter")
            profile_hash[:twitter] = link
          elsif link.include?("linkedin")
            profile_hash[:linkedin] = link
          elsif link.include?("github")
            profile_hash[:github] = link
          else
            profile_hash[:blog] = link
          end
        end
      end
      profile_hash
    end

end
