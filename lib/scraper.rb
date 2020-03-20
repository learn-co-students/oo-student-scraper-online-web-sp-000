require 'nokogiri'
require 'open-uri'
require 'pathname'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    #get all students
    student_cards = doc.css(".student-card")

    #make student objects
    students = []

    student_cards.each do |card|
      student_hash = {}
      #puts card
      student_hash[:name] = card.css(".student-name").text
      student_hash[:location] = card.css(".student-location").text
      student_hash[:profile_url] = card.css("a")[0]["href"]
      #puts student_hash

      students << student_hash
    end
    students

  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    student_hash = {}

    #student_hash[:name] = doc.css(".profile-name").text
    #student_hash[:location] = doc.css(".profile-location").text
    container = doc.css(".social-icon-container")
    links = container.css("a")

    student_hash[:twitter] = get_link(links, "twitter") if get_link(links, "twitter")
    student_hash[:linkedin] = get_link(links, "linkedin") if get_link(links, "linkedin")
    student_hash[:github] = get_link(links, "github") if get_link(links, "github")

    blog_tag = container.css(".social-icon").select {|img|
      img if img['src'].include?("rss")
    }.first
    blog_link = blog_tag.parent['href'] if blog_tag
    student_hash[:blog] = blog_link if blog_link

    student_hash[:profile_quote] = doc.css(".profile-quote").text
    student_hash[:bio] = doc.css(".description-holder p").text

    student_hash
  end

  def self.get_link(links, service)
    my_tag = links.select{|link|
        link['href'].match(/#{service}/)
      }.first
    my_tag['href'] if my_tag

  end

end
