require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_page(url)
    Nokogiri::HTML(open(url))
  end

  def self.scrape_index_page(index_url)
    students = []
    doc = self.scrape_page(index_url)

    students_html = doc.search(".student-card")
    students_html.each do |html|
      students << {
        name: html.search("h4.student-name").text,
        location: html.search("p.student-location").text,
        profile_url: html.search("a").attribute('href').value
      }
    end
    
    students
  end

  def self.scrape_profile_page(profile_url)
    html = self.scrape_page(profile_url)

    # Assign initial student details
    student = {
      profile_quote: html.search(".profile-quote").text,
      bio: html.search(".bio-content p").text,
    }

    # Assign social links
    social_links = self.get_social_links(html.search(".social-icon-container a"))
    social_links.each do |k, v|
      if social_links[k]
        student[k] = v
      end
    end

    student
  end

  def self.get_social_links(divs)
    social_links = {}

    divs.each do |div|
      # Twitter
      if div.attribute('href').value.include?('twitter')
        social_links[:twitter] = div.attribute('href').value

      #LinkedIn
      elsif div.attribute('href').value.include?('linkedin')
        social_links[:linkedin] = div.attribute('href').value

      #Github
      elsif div.attribute('href').value.include?('github')
        social_links[:github] = div.attribute('href').value

      # Blog [Fallback]
      else
        social_links[:blog] = div.attribute('href').value
      end
    end

    social_links
  end

end
