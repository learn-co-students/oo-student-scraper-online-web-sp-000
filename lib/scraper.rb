require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :index_site, :profile_site

  def self.scrape_index_page(index_url)
    # array of hashes in which each hash represents a single student.
    # student = {:name, :location, :profile_url}
    @index_site = Nokogiri::HTML(open(index_url))
    students = []
    get_names.each_with_index do |name, i|
      location = get_locations[i]
      profile_url = get_profile_urls(index_url)[i]
      student = {name: name, location: location, profile_url: profile_url}
      students << student
    end
    students
  end

  def self.get_names
    names = []
    @index_site.css(".roster-cards-container").css("h4").css(".student-name").each do |card|
      names << card.text
    end
    names
  end

  def self.get_locations
    locations = []
    @index_site.css(".roster-cards-container").css("p").css(".student-location").each do |card|
      locations << card.text
    end
    locations
  end

  def self.get_profile_urls(index_url)
    profile_urls = []
    url_string = index_url.gsub("index.html", "students/")
# **********************************************
# binding.pry
# **********************************************
    get_names.each_with_index do |s|
      url = "students/#{s.split(" ").first.downcase}-#{s.split(" ").last.downcase}.html"

      profile_urls << url

    end

    profile_urls
  end

  # def make_student_ha
  #   student = {name: , location: , profile_url: }
  # end

  def self.scrape_profile_page(profile_url)
    @profile_site = Nokogiri::HTML(open(profile_url))
    twitter, linkedin, github, blog, quote, bio = "", "", "", "", "", ""
    student = {}
    # hash in which the key/value pairs describe an individual student.
    twitter = @profile_site.css("a")[1].values.first if @profile_site.css("a")[1].values.first.include? "twitter"
    linkedin = @profile_site.css("a")[2].values.first if @profile_site.css("a")[2].values.first.include? "linkedin"
    if @profile_site.css("a")[3]
      if @profile_site.css("a")[3].values.first.include? "github"
        github = @profile_site.css("a")[3].values.first
      else
        github = ""
      end
    else
      github = ""
    end
    blog = @profile_site.css("a")[4].values.first if @profile_site.css("a")[4]
    quote = @profile_site.css("div.vitals-text-container")[0].text.split("\n")[3].strip if @profile_site.css("div.vitals-text-container")[0]
    bio = @profile_site.css("div.description-holder").first.text.split("\n")[1].strip if @profile_site.css("div.description-holder")

    student = {
      twitter: twitter,
      linkedin: linkedin,
      github: github,
      blog: blog,
      profile_quote: quote,
      bio: bio
      # twitter: @profile_site.css("div.social-icon-container a").first.values.first
    }

    student.delete_if { |k,v| v == ""}
# /html/body/div/div[3]/div[1]/div/div[2]/p/text()
# body div div.details-container div.bio-block.details-block div div.description-holder
  end

end

# 2.6.1 :076 > p.css("div.social-icon-container a").first.values.first
#  => "https://twitter.com/empireofryan" 
# 2.6.1 :077 > p.css("div.social-icon-container a")[1].values.first
#  => "https://www.linkedin.com/in/ryan-johnson-321629ab" 
# 2.6.1 :078 > p.css("div.social-icon-container a")[2].values.first
#  => "https://github.com/empireofryan" 
# 2.6.1 :079 > p.css("div.social-icon-container a")[3].values.first
#  => "https://www.youtube.com/watch?v=C22ufOqDyaE" 
# quote = body > div > div.vitals-container > div.vitals-text-container > div
# require 'nokogiri'
# require 'open-uri'
# require 'pry'

# {:bio=>"I'm a southern California native seeking to find work as a full stack web developer. I enjoyi...ngs!", :profile_quote=>"\"Yeah, well, you know, that's just, like, your opinion, man.\" - The Dude"}
# {:linkedin=>"https://www.linkedin.com/in/david-kim-38221690", :github=>"https://github.com/davdkm", :profile_quote=>"\"Yeah, well, you know, that's just, like, your opinion, man.\" - The Dude", :bio=>"I'm a southern California native seeking to find work as a full stack web developer. I enjoying tinkering with computers and learning new things!"}