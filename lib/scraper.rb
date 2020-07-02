require "open-uri"
require "pry"

class Scraper
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students = []

    doc.css(".roster-cards-container").each do |student_card|
      student_card.css(".student-card").each do |student|
        name = student.css("h4").text
        students << {
          name: student.css("h4").text,
          location: student.css("p").text,
          profile_url: student.css("a").attr("href").value,
        }
      end
    end
    students

    #binding.pry
    #to get name of student: doc.css(".student-card").first.css("h4").text
    #to get location where student is from: doc.css(".student-card").first.css("p").text
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_page = {}
    #binding.pry

    doc.css(".social-icon-container").children.css("a").each do |link|
      if link.attributes["href"].value.include?("twitter")
        profile_page[:twitter] = link.attributes["href"].value
      elsif link.attributes["href"].value.include?("linkedin")
        profile_page[:linkedin] = link.attributes["href"].value
      elsif link.attributes["href"].value.include?("github")
        profile_page[:github] = link.attributes["href"].value
      else
        profile_page[:blog] = link.attributes["href"].value
      end
      # twitter = profile.css()
      # profile[twitter.to_sym] = ""
      #if string contains twitter.. put it as the twitter value.
      #then it has to be the blog.
    end
    profile_page[:profile_quote] = doc.css(".vitals-text-container").first.children[5].children.text
    profile_page[:bio] = doc.css("p").first.text
    profile_page
  end
end

# return the projects hash
