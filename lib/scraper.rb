require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    index_info = doc.css("div.student-card a")
    index_info.map { |student_element|
      {
        :name => student_element.css("h4.student-name").text,
        :location => student_element.css("p.student-location").text,
        :profile_url => student_element['href']
      }
    }
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_element = doc.css("div.main-wrapper.profile")[0]
    profile_info = {}
    social_elements = profile_element.css("div.social-icon-container a")
    social_elements.each do |element|
      indivdual_social_link = element['href']
      if indivdual_social_link.include?("twitter")
        profile_info[:twitter] = indivdual_social_link
      elsif indivdual_social_link.include?("linkedin")
        profile_info[:linkedin] = indivdual_social_link
      elsif indivdual_social_link.include?("github")
        profile_info[:github] = indivdual_social_link
      else
        profile_info[:blog] = indivdual_social_link
      end
    end
    profile_info[:profile_quote] = profile_element.css("div.profile-quote").text
    profile_info[:bio] = profile_element.css("div.description-holder p").text
    return profile_info
  end

end
