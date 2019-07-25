# require 'Nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []

    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.student-card").each do |student|
    student_info = {}
    student_info[:location] = student.css("p.student-location").text
    student_info[:name] = student.css("h4.student-name").text
    student_info[:profile_url] = student.css("a").attribute("href").value
    students << student_info
  end
    students
# binding.pry
  end
  # def self.scrape_profile_page(profile_url)
  #       page = Nokogiri::HTML(open(profile_url))
  #       student = {}
  #
  #       # student[:profile_quote] = page.css(".profile-quote")
  #       # student[:bio] = page.css("div.description-holder p")
  #       container = page.css(".social-icon-container a").collect{|icon| icon.attribute("href").value}
  #       container.each do |link|
  #         if link.include?("twitter")
  #           student[:twitter] = link
  #         elsif link.include?("linkedin")
  #           student[:linkedin] = link
  #         elsif link.include?("github")
  #           student[:github] = link
  #         elsif link.include?(".com")
  #           student[:blog] = link
  #         end
  #       end
  #       student[:profile_quote] = page.css(".profile-quote").text
  #       student[:bio] = page.css("div.description-holder p").text
  #       student
  #   end
  #
  # end
  def self.scrape_profile_page(profile_url)
    student = {}
    doc = Nokogiri::HTML(open(profile_url))
    links = doc.css(".social-icon-container a").collect do |icon|
      icon.attribute("href").value
    end
      links.each do |link|
        if link.include?("twitter")
           student[:twitter] = link
        elsif link.include?("linkedin")
              student[:linkedin] = link
        elsif link.include?("github")
              student[:github] = link
        elsif link.include?(".com")
               student[:blog] = link
        end
      end
    student[:profile_quote] = doc.css(".profile-quote").text
    student[:bio] = doc.css("div.description-holder p").text
    # student[:bio] = page.css("div.description-holder p").text
   student
  #  binding.pry
 end
    # twitter
    # likedin url
    # github url
    # blog url
    # profile quote
    # bio h3.p.text
end
