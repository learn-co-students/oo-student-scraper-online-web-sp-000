require 'open-uri'
require 'pry'

class Scraper

  # get student attributes: doc.css("div.roster-cards-container")
  # get student names: doc.css("div h4.student-name").text.strip
  # get locations: doc.css("p.student-location").text.strip
  # get profile urls: doc.css("div.student-card a").map {|link| link["href"]}


  def self.scrape_index_page(index_url)
    # responsible for scraping the index page that lists
    # all of the students
    doc = Nokogiri::HTML(open(index_url))
    # gets student names
    #binding.pry
    puts "scrape_index_page"
    doc.css("div.student-card").collect do |student|
      {
        :name => student.css("div h4.student-name").text.strip,
        :location => student.css("p.student-location").text.strip,
        :profile_url => student.css("a").map {|link| link["href"]}.join(" ").strip
      }
    end

    #binding.pry
  end

  def self.scrape_profile_page(profile_url)
    # responsible for scraping an individual student's profile page
    # to get further info about that student
    puts "scrape_profile_page"
    page = Nokogiri::HTML(open(profile_url))
    student_hash = {}
    student_page = page.css("div.social-icon-container a").map {|link| link["href"]}
    student_quote = page.css("div.profile-quote").text.strip if page.css("div.profile-quote")
    student_bio = page.css("div.description-holder p").text.strip if page.css("div.description-holder p")
    #binding.pry
    student_hash[:profile_quote] = student_quote
    student_hash[:bio] = student_bio
    student_page.each do |link|
      if link.include?("twitter")
        student_hash[:twitter] = link
      elsif link.include?("linkedin")
        student_hash[:linkedin] = link
      elsif link.include?("github")
        student_hash[:github] = link
      else
        student_hash[:blog] = link
      end
    end
    student_hash
    #binding.pry
  end

end
