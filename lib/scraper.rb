require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    #doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
    students = []

    #List of students: <div class="roster-cards-container"> == $0
    #A single student <div class="student-card" id="ryan-johnson-card"> / doc.css("div.student-card")
    #:name <h4 class="student-name">Ryan Johnson</h4> / doc.css("h4.student-name").text
    #:location <p class="student-location">New York, NY</p> / doc.css("p.student-location").text
    #:profile_url <a href="students/ryan-johnson.html"> / doc.css("div.student-card a").attribute("href").value

    #desired output for a single student
    #{:name => "Abby Smith", :location => "Brooklyn, NY", :profile_url => "students/abby-smith.html"}

    doc.css("div.student-card").each_with_index do |student, index|
      #binding.pry
      students[index] = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    #full_url = "https://learn-co-curriculum.github.io/student-scraper-test-page/" + profile_url
    #doc = Nokogiri::HTML(open(full_url))
    doc = Nokogiri::HTML(open(profile_url))

    profile = {}

    twitterURL = nil;
    linkedinURL = nil;
    githubURL = nil;
    blogURL = nil;

    #Get the social URLs (if they exist)
    doc.css("div.social-icon-container a").each do |item|
      if item.attribute("href").value.include? "twitter"
        profile[:twitter] = item.attribute("href").value
      elsif item.attribute("href").value.include? "linkedin"
        profile[:linkedin] = item.attribute("href").value
      elsif item.attribute("href").value.include? "github"
        profile[:github] = item.attribute("href").value
      else
        profile[:blog] = item.attribute("href").value
      end
    end

    profile[:profile_quote] = doc.css("div.profile-quote").text
    profile[:bio] = doc.css("div.description-holder p").text

    profile
    
    #binding.pry
    #my_hash[:key] = "value"
    #Use Joe Burgess - he has every kind of link: https://learn-co-curriculum.github.io/student-scraper-test-page/students/joe-burgess.html
    #Social icon container:
        #<div class="social-icon-container"> / doc.css("div.social-icon-container")
        #    <a href="https://twitter.com/jmburges"><img class="social-icon" src="../assets/img/twitter-icon.png"></a>
        #    <a href="https://www.linkedin.com/in/jmburges"><img class="social-icon" src="../assets/img/linkedin-icon.png"></a>
        #    <a href="https://github.com/jmburges"><img class="social-icon" src="../assets/img/github-icon.png"></a>
        #    <a href="http://joemburgess.com/"><img class="social-icon" src="../assets/img/rss-icon.png"></a>
        #  </div>
    #:twitter <a href="http://www.github.com/jamesnvk"><img class="social-icon" src="../assets/img/github-icon.png"></a>
    #:linkedin <a href="https://www.linkedin.com/in/james-novak-3ba89266"><img class="social-icon" src="../assets/img/linkedin-icon.png"></a>
    #:github <a href="http://www.github.com/jamesnvk"><img class="social-icon" src="../assets/img/github-icon.png"></a>
    #:blog <a href="http://joemburgess.com/"><img class="social-icon" src="../assets/img/rss-icon.png"></a> - tricky
    #social links are contained in the array:
    #...doc.css("div.social-icon-container a")[0].attribute("href").value
    #...but different people have different ones, so you'll need to search for the strings "twitter" "linkedin" "github" "instagram"
    #...the blog can be anything, so it would just have to be the URL that ISN'T one of those
    #:profile_quote <div class="profile-quote">Always learning.</div> / doc.css("div.profile-quote").text
    #:bio <div class="description-holder"><p>Gym rat, nerd. Excited to be a part of this awesome community as I learn to love code. </p></div> / doc.css("div.description-holder p").text

  end

end

#Scraper.scrape_index_page("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html")
#Scraper.scrape_profile_page("students/joe-burgess.html")
