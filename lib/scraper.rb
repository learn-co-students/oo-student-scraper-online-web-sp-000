require 'open-uri'
require 'pry'

class Scraper



  def self.scrape_index_page(index_url)
    get_page = Nokogiri::HTML(open(index_url))
    students = []

    student_list = get_page.css("div.student-card")
    student_list.each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = student.css("a").attribute("href").value
      student_info = {:name => name, :location => location,
                      :profile_url => profile_url}
      students << student_info
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    get_page = Nokogiri::HTML(open(profile_url))
    student = {}

    profile_details = get_page.css(".social-icon-container a").map {|site| site.attribute("href").value}
    profile_details.each do |link|
      if link.include?('twitter')
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?(".com")
        student[:blog] = link
      end
    end
    student[:profile_quote] = get_page.css(".profile-quote").text
    student[:bio] = get_page.css(".description-holder p").text
    student
  end

end
