require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read("fixtures/student-site/index.html")
    noko_doc = Nokogiri::HTML(html)
    student_array = []

    # iterate through students
    # name = student.css("a .card-text-container h4.student-name").text
    # location = student.css("a .card-text-container p.student-location").text
    # profile_url = student.css("a").attribute("href").value
    noko_doc.css(".student-card").each do |student|
      student_array <<
        {
          :name => student.css("a .card-text-container h4.student-name").text,
          :location => student.css("a .card-text-container p.student-location").text,
          :profile_url => student.css("a").attribute("href").value
        }
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    noko_doc = Nokogiri::HTML(open(profile_url))

    profile_quote = noko_doc.css(".profile-quote").text.strip
    bio = noko_doc.css(".bio-content.content-holder .description-holder").text.strip

    twitter = ""
    linkedin = ""
    github = ""
    blog = ""
    noko_doc.css(".social-icon-container a").each do |node|
      value = node.attribute("href").value
      if value.include? "linkedin"
        linkedin = value
      elsif value.include? "github"
        github = value
      elsif value.include? "twitter"
        twitter = value
      else
        blog = value
      end
    end
    student_hash = {}

    if !twitter.empty?
      student_hash[:twitter] = twitter
    end
    if !linkedin.empty?
      student_hash[:linkedin] = linkedin
    end
    if !github.empty?
      student_hash[:github] = github
    end
    if !blog.empty?
      student_hash[:blog] = blog
    end
    student_hash[:profile_quote] = profile_quote
    student_hash[:bio] = bio

    student_hash
  end

end
