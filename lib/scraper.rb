require 'open-uri'

class Scraper
  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    scraped_student = index_page.css(".student-card")
    student_index_array = []

    scraped_student.map do |student|
      student_hash = {
        name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: student.css("a")[0]["href"]
      }
      student_index_array << student_hash
    end
    student_index_array
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student_profile = profile_page.css(".vitals-container")
    student_bio = profile_page.css(".bio-content p").text
    student_profile_quote = profile_page.css(".profile-quote").text
    student_attr_hash = {}
    social_media_name_array = [:twitter, :linkedin, :github, :blog]
    student_profile.map do |attribute|
      attribute.css(".social-icon-container a").map do |social_link| 
        social_link.map do |link| 
          social_media_name_array.map do |platform|
            if link[1].include?(platform.to_s)
              student_attr_hash[platform] = link[1]
              social_media_name_array.delete(platform)
            elsif social_media_name_array.length == 1
              student_attr_hash[platform] = link[1]
            end
          end
        end
      end
    end
    student_attr_hash[:bio] = student_bio
    student_attr_hash[:profile_quote] = student_profile_quote
    student_attr_hash
  end
end