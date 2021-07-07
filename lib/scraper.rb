require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    student_cards = page.css('div.student-card')

    student_cards.map do |student|
    # binding.pry
      {
        name: student.css('h4').text,
        location: student.css('p').text,
        profile_url: student.css('a').attribute('href').text 
      }
    end
    # binding.pry
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    profile_info = page.css('div.vitals-container')
    # \binding.pry
    student_profile = {}

    profile_info.css('a').each do |link|
      # binding.pry
      if link.css('img.social-icon').attribute('src').value == "../assets/img/twitter-icon.png"
        student_profile[:twitter] = link.attributes['href'].value
      elsif link.css('img.social-icon').attribute('src').value == "../assets/img/linkedin-icon.png"
        student_profile[:linkedin] = link.attributes['href'].value
      elsif link.css('img.social-icon').attribute('src').value == "../assets/img/github-icon.png"
        student_profile[:github] = link.attributes['href'].value
      elsif link.css('img.social-icon').attribute('src').value == "../assets/img/rss-icon.png"
        student_profile[:blog] = link.attributes['href'].value
      end
    end
          
    student_profile[:profile_quote] = profile_info.css('div.profile-quote').text
    student_profile[:bio] = page.css('div.description-holder p').text
  #  binding.pry   
    student_profile
  end

end

