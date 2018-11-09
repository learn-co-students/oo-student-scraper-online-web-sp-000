require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
    def self.scrape_index_page(index_url)
    
        allStus = []
        
        doc = Nokogiri::HTML(open(index_url))
        mydoc = doc.css(".roster-cards-container .student-card")
        mydoc.each do |student|
            stu = {
                name: student.css(".card-text-container .student-name").text,
                location: student.css(".card-text-container .student-location").text,
                profile_url: student.css("a")[0]["href"]
            }
        allStus << stu
        end
        allStus
    end

    def self.scrape_profile_page(profile_url)
        doc = Nokogiri::HTML(open(profile_url))
        mysoc = doc.css(".main-wrapper .vitals-container .social-icon-container")

        tw = nil
        li = nil
        gh = nil
        bl = nil

        for i in 1..mysoc.css("a").size do
            if mysoc.css("a")[i-1]["href"].include?("twitter.com")
                tw = mysoc.css("a")[i-1]["href"]
            elsif mysoc.css("a")[i-1]["href"].include?("linkedin.com")
                li = mysoc.css("a")[i-1]["href"]
            elsif mysoc.css("a")[i-1]["href"].include?("github.com")
                gh = mysoc.css("a")[i-1]["href"]
            else
                bl = mysoc.css("a")[i-1]["href"]
            end
        end
        
        desc = {
            twitter: tw,
            linkedin: li,
            github: gh,
            blog: bl,
            profile_quote: doc.css(".main-wrapper .vitals-text-container .profile-quote").text,
            bio: doc.css(".details-container .bio-block .bio-content .description-holder").text.gsub("\n","").strip
        }
        #compact gets rid of key/values where value is nil.
        desc.compact
    end
end
