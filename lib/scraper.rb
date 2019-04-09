require 'open-uri'
require 'pry'
require 'nokogiri'


class Scraper

  def self.scrape_index_page(index_url)
    arr = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css(".student-card").each do |x|
      index = {}
      index[:name] = x.css("a div h4").text
      index[:location] = x.css("a div p").text
      index[:profile_url] = x.css("a").attribute("href").value
      arr.push(index)
    end
  arr
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    arr = [
      doc.css(".main-wrapper").css(".profile div div a").map {|x| x.attribute("href").value}[0],
      doc.css(".main-wrapper").css(".profile div div a").map {|x| x.attribute("href").value}[1],
      doc.css(".main-wrapper").css(".profile div div a").map {|x| x.attribute("href").value}[2],
      doc.css(".main-wrapper").css(".profile div div a").map {|x| x.attribute("href").value}[3],
      doc.css(".main-wrapper").css(".profile div div div").css(".profile-quote").text,
      doc.css(".main-wrapper").css(".profile div div div div p").text
    ]

    index = {}

    arr.each do |x|
      index[:twitter] = x if (x && x.include?("twitter.com"))
      index[:linkedin] = x if (x && x.include?("linkedin.com"))
      index[:github] = x if (x && x.include?("github.com"))
      index[:blog] = x if (x && x.include?("http:"))
      index[:profile_quote] = x if (x && x.include?("\""))
      index[:bio] = x if (x && x.match(/\s\w+\.|!/))
    end

    index
    #  index[:twitter] = doc.css(".main-wrapper").css(".profile div div a").map {|x| x.attribute("href").value}[0]
    #  index[:linkedin] = doc.css(".main-wrapper").css(".profile div div a").map {|x| x.attribute("href").value}[1]
    #  index[:github] = doc.css(".main-wrapper").css(".profile div div a").map {|x| x.attribute("href").value}[2]
    #  index[:blog] = doc.css(".main-wrapper").css(".profile div div a").map {|x| x.attribute("href").value}[3]
    #  index[:profile_quote] = doc.css(".main-wrapper").css(".profile div div div").css(".profile-quote").text
    #  index[:bio] = doc.css(".main-wrapper").css(".profile div div div div p").text
    end
  end
  #:twitter = doc.css(".main-wrapper").css(".profile div div a").map {|x| x.attribute("href").value}[0]
  #:linkedin = doc.css(".main-wrapper").css(".profile div div a").map {|x| x.attribute("href").value}[1]
  #:github = doc.css(".main-wrapper").css(".profile div div a").map {|x| x.attribute("href").value}[2]
  #:blog = doc.css(".main-wrapper").css(".profile div div a").map {|x| x.attribute("href").value}[3]
  #:profile_quote = doc.css(".main-wrapper").css(".profile div div div").css(".profile-quote").text
  #:bio = doc.css(".main-wrapper").css(".profile div div div div p").text
