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
    doc.css().each do |profile|
      twitter = profile.css()
      profile[twitter.to_sym] = ""
    end
  end
end

# return the projects hash
