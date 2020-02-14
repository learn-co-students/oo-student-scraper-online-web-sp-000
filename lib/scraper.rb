require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    profiles=[]
    doc=Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/"))
    students=doc.css("div.student-card")
    students.each do |student|
      profile={:location=>student.css("p.student-location").text,
        :name=>student.css("h4.student-name").text,
      :profile_url=>student.css("a").attribute("href").value}
      profiles<<profile
    end
    profiles
  end

  def self.scrape_profile_page(profile_url)
    stu_hash={}
    per_info=Nokogiri::HTML(open(profile_url))
    per_info.css("div.social-icon-container a").map{|anchor| anchor["href"]}.each do |information|
      stu_hash[:twitter]=information if information.include?("twitter")
      stu_hash[:linkedin]=information if information.include?("linkedin")
      stu_hash[:github]=information if information.include?("github")
      stu_hash[:blog]=information if information.end_with?("com/")
    end
    stu_hash[:profile_quote]=per_info.css("div.profile-quote").text
    stu_hash[:bio]=per_info.css("p").text
    stu_hash
  end



end
#https://stackoverflow.com/questions/6471085/scrape-urls-from-web
#student_page=per_info.css(".social-icon-container").first
#personal_info=student_page.css("a").first["href"]

#  per_page=puts per_info.css(".vitals-container .social-icon-container a")
#per_page.each do |page|
#  puts page
#family_hash={}
#family=["Michael", "Brandon","Joshua"]

#family.collect do |child|
#family_hash={:Oldest=>child if child.include?("Michael"),
#:Second=>child if child.include?("Brandon"),
#:Third=>child if child.include?("Joshua")}
#family_hash
