require 'open-uri'
require 'pry'

class Scraper
    
    def self.scrape_index_page(index_url)
        
        # Makes HTTP requrest for required URL.
        html = open(index_url)

        # Parses webpage HTMl into a nested array of hashes.
        webpage = Nokogiri::HTML(html)

        students_array = []
        
        webpage.css("div.roster-cards-container .student-card").each do |card|
            
            students_hash = {}
            
            students_hash[:name] = card.css("h4.student-name").text
            students_hash[:location] = card.css("p.student-location").text
            students_hash[:profile_url] = card.css("a").attribute("href").value

            students_array << students_hash
            
        end
        students_array
    end

    def self.scrape_profile_page(profile_url)

        # Makes HTTP requrest for required URL.
        html = open(profile_url)

        # Parses webpage HTMl into a nested array of hashes.
        webpage = Nokogiri::HTML(html)
        
        profile_hash = {}

        # Locates the bio text, removes any line or white space, and assigns the pair to a hash.
        profile_hash[:bio] = webpage.css("div.bio-content div.description-holder").text.strip

        # Locates profile quote and assigns the pair to a hash.
        profile_hash[:profile_quote] = webpage.css("div.profile-quote").text

        # This iterates over anchor tags to retrieve and assign values based on social media platform.
        webpage.css("div.social-icon-container a").each do |platform|
            
            if platform.attributes["href"].value.include?("twitter")
                profile_hash[:twitter] = platform.attributes["href"].value
            elsif platform.attributes["href"].value.include?("linkedin")
                profile_hash[:linkedin] = platform.attributes["href"].value
            elsif platform.attributes["href"].value.include?("github")
                profile_hash[:github] = platform.attributes["href"].value
            else
                profile_hash[:blog] = platform.attributes["href"].value 
            end
        end
        profile_hash
    end

end

