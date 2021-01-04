require 'open-uri'
require 'pry'

class Scraper

  @@all = []

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
    roster_cards = doc.css(".student-card")

    roster_cards.each do |card|
      student_name = card.css(".student-name").text
      student_location = card.css(".student-location").text
      student_url = card.css("a")[0].attributes["href"].value

      student = {name: student_name, location: student_location, profile_url: student_url}
      @@all << student
    end
    @@all
  end


  def self.scrape_profile_page(profile_url)
# set up file
    doc = Nokogiri::HTML(open(profile_url))

    twitter_link = nil
    linkedin_link = nil
    github_link = nil
    blog_link = nil
    profile_quote = nil
    bio = nil

# get all the attributes from the page
    # hrefs to compare
    hrefs = doc.css(".social-icon-container a")

    # search each of the hrefs for needed info
    hrefs.each do |href|
      # twitter
      if href.attributes["href"].text.include?("twitter")
        twitter_link = href.attributes["href"].text
      # linkedin
      elsif href.attributes["href"].text.include?("linkedin")
        linkedin_link = href.attributes["href"].text
      # github
      elsif href.attributes["href"].text.include?("github")
        github_link = href.attributes["href"].text
      # blog
      else
        blog_link = href.attributes["href"].text
      end
    end

    # profile quote
    profile_quote = doc.css(".profile-quote").text
    # bio
    bio = doc.css(".bio-content.content-holder p").text

# assemble hash with student info
    student_info = {
      twitter:        twitter_link,
      linkedin:       linkedin_link,
      github:         github_link,
      blog:           blog_link,
      profile_quote:  profile_quote,
      bio:            bio
    }

    # remove any empty entries
    student_info = student_info.delete_if{|k, v| v.nil?}
  end

end
