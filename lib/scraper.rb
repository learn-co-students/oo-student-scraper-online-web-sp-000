require 'open-uri'
require 'pry'
# require 'Nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    page.css("div.student-card").collect do |student|
      s_name = student.css("h4.student-name").text
      s_local = student.css("p.student-location").text
      s_url = student.css("a").attr("href").value
      {name: s_name, location: s_local, profile_url: s_url}
    end
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    social_media_raw = page.css("div.social-icon-container")
    url_list = social_media_raw.css("a").map { |el| el.attribute('href').value}
    student_info = {}
    url_list.each do |url|
      case url
      when /.*twitter.com.*/
        student_info[:twitter] = url
      when  /.*linkedin.com.*/
        student_info[:linkedin] = url
      when  /.*github.com.*/
        student_info[:github] = url
      else
        student_info[:blog] = url
      end
    end
    student_info[:profile_quote] = page.css("div.profile-quote").text
    student_info[:bio] = page.css("div.description-holder p").text
    student_info.compact
  end

end

