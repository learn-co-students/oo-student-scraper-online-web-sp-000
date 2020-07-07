require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css("div.student-card").collect do |student|
      {:name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text,
      :profile_url => student.css("a").attr("href").value
      }
    end



  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_profile = {}

    doc.css("div.vitals-container div.social-icon-container a").each do |e|
      if e.attr("href").include?("twitter")
        student_profile[:twitter] = e.attr("href")
      elsif e.attr("href").include?("linkedin")
        student_profile[:linkedin] = e.attr("href")
      elsif e.attr("href").include?("github")
        student_profile[:github] = e.attr("href")
      else
        student_profile[:blog] = e.attr("href")
      end
    end

    student_profile[:bio] = doc.css("div.details-container div.description-holder p").text
    student_profile[:profile_quote] = doc.css("div.vitals-text-container div.profile-quote").text

    student_profile
  end

end
