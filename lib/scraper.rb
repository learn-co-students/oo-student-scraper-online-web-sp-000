require 'open-uri'
require 'pry'

class Scraper

  #:name - students.css(".student-name").text
  #:location - students.css(".student-location").text
  #:profile-link - students.css("a").attr("href").value


  #array of social: profile_info.css(".social-icon-container a").map {|link| link["href"]}
  #:twitter
  #:linkedin
  #:github
  #:blog
  #:profile_quote - profile_info.css(".profile-quote").text
  #:bio - profile_info.css(".description-holder p").text


  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students = doc.css(".student-card")
    students.collect do |student|
      {name: student.css(".student-name").text,
       location: student.css(".student-location").text,
       profile_url: student.css("a").attr("href").value}
    end

  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    profile_info = doc.css(".profile")
    social_info = profile_info.css(".social-icon-container a").map {|link| link["href"]}

    profile_quote = profile_info.css(".profile-quote").text
    bio = profile_info.css(".description-holder p").text

    hash = {bio: bio, profile_quote: profile_quote}

    social_info.each do |item|
      if item.include?("twitter")
        hash[:twitter] = item
      elsif item.include?("linkedin")
        hash[:linkedin] = item
      elsif item.include?("github")
        hash[:github] = item
      elsif item.include?("facebook")
      else
        hash[:blog] = item
      end
    end

    hash

  end

end

