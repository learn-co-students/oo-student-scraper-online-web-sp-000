require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    student_cards = []
    html.css(".student-card").each do |student|
      hash = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      student_cards << hash
    end
    student_cards
  end

#   def self.scrape_profile_page(profile_url)
#     html = Nokogiri::HTML(open(profile_url))
#     student_info = {}
#     social_container = html.css(".social-icon-container a").collect {|icon| icon.attribute("href").value}
#       social_container.each do |link|
#         if link.include?("twitter")
#           student_info[:twitter] = link
#         elsif link.include?("linkedin")
#           student_info[:linkedin] = link
#         elsif link.include?("github")
#           student_info[:github] = link
#         else
#           student_info[:blog] = link
#         end
#       end
#       student_info[:profile_quote] = html.css(".profile-quote").text
#       student_info[:bio] = html.css(".description-holder p").text
#     end
#     student_info
#   end

# end

  def self.scrape_profile_page(profile_url)

    html = Nokogiri::HTML(open(profile_url))
    student_info = {}

    social_container = html.css(".social-icon-container a").collect {|icon| icon.attribute("href").value}

      social_container.each do |link|
        if link.include?("twitter")
          student_info[:twitter] = link
        elsif link.include?("linkedin")
          student_info[:linkedin] = link
        elsif link.include?("github")
          student_info[:github] = link
        else
          student_info[:blog] = link
        end
      end

      student_info[:bio] = html.css('.description-holder p').text
      student_info[:profile_quote] = html.css('.profile-quote').text
      student_info
  end
end	   		 