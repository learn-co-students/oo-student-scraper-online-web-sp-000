require 'open-uri'
require 'pry'
require 'nokogiri'
#https://learn-co-curriculum.github.io/student-scraper-test-page/index.html
class Scraper
#  doc=Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/"))
#  binding.pry
  def self.scrape_index_page(index_url)
  #  doc.css(".main-wrapper .student-card").collect do |info|
  #    {:name => info.css("h4").text, :location => info.css("p").text, :profile_url => info.css('a').attribute("href").text}
  #  student_name= doc.css(".main-wrapper .student-card").first.css("h4").text
  #  student_location = doc.css(".main-wrapper .student-card").first.css("p").text
  #  student_profile = doc.css(".main-wrapper .student-card").first.css("a").attribute("href").text
    doc=Nokogiri::HTML(open(index_url))

    doc.css(".main-wrapper .student-card").collect do |info|

      {:name => info.css("h4").text, :location => info.css("p").text, :profile_url => info.css('a').attribute("href").text}

    end
  end

  attr_accessor :twitter, :linkedin, :github, :blog, :profile_quote, :bio

  def self.scrape_profile_page(profile_url)
#   doc2= Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html"))
    doc2= Nokogiri::HTML(open(profile_url))
  #  doc2= Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/students/david-kim.html"))
  # binding.pry

    final_attributes = { }

    doc2.css("div.social-icon-container a").each do |link|
      if "#{link.attribute("href").text}".include?("twitter")
        final_attributes[:twitter] = "#{link.attribute("href").text}"

      elsif "#{link.attribute("href").text}".include?("linkedin")
        final_attributes[:linkedin] = "#{link.attribute("href").text}"

      elsif "#{link.attribute("href").text}".include?("github")
        final_attributes[:github] = "#{link.attribute("href").text}"

      end
    end

  #  links=doc2.css("div.social-icon-container a").collect {|link| link.attributes["href"]}

  # blog_link = doc2.css("div.social-icon-container a")[3].attribute("href").text
    blog_link = doc2.css("div.social-icon-container a")[3]                          # Caution!!! if there isn't a fourth link, calling the css "attribute" method to extract the text from the element "doc2.css("div.social-icon-container a")[3]" will produce a nomethod error. This will cause issues with profiles that do not cotain a 4th link.
    if blog_link != nil
      final_attributes[:blog] = blog_link.attribute("href").text
    end
    final_attributes[:profile_quote] = doc2.css("div.profile-quote").text
    final_attributes[:bio] = doc2.css("div.description-holder p").text
    final_attributes
    
  end

end

#doc2.css("div.social-icon-container a").each {|i| puts "#{i}"}
  #  attributes= [
  #               :twitter => doc2.css("div.social-icon-container a")[0].attribute("href").text,
  #               :linkedin => doc2.css("div.social-icon-container a")[1].attribute("href").text,
  #               :github => doc2.css("div.social-icon-container a")[2].attribute("href").text,
  #               :blog => doc2.css("div.social-icon-container a")[3].attribute("href").text,
  #               :profile_quote => doc2.css("div.profile-quote").text,
  #               :bio => doc2.css("div.description-holder p").text
  #  ]
