require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)

    index_page = Nokogiri::HTML(html)

    students = []

    index_page.css('.student-card').each do |student|
      students << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a")[0]['href']
      }
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    student_page = Nokogiri::HTML(html)
    
    student = {
      :twitter => nil,
      :linkedin => nil,
      :github => nil ,
      :blog => nil ,
      :profile_quote => nil ,
      :bio => nil
    }
    
    student_page.css("div.social-icon-container a").each do |link|
      if link['href'].include?("twitter")
        student[:twitter] = link['href']
      end
      if link['href'].include?("github")
        student[:github] = link['href']
      end
      if link['href'].include?("linkedin")
        student[:linkedin] = link['href']
      end
      if link.css(".social-icon")[0]['src'] == "../assets/img/rss-icon.png"
        student[:blog] = link['href']
      end
      binding.pry
    end

    student[:profile_quote] = student_page.css("div.profile-quote")[0].text.strip
    student[:bio] = student_page.css("div.description-holder")[0].text.strip

    student
  end

end

