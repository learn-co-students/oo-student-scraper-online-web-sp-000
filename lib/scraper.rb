require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    student_cards = doc.css('.student-card')

    student_cards.map { |student_card|

	    container = student_card.css('div.card-text-container')

	    student_hash = {
	    	name: container.css('.student-name').text, 
	    	location: container.css('.student-location').text, 
	    	profile_url: student_card.css('a').attribute('href').value
	    }
	  }
  end

  def self.scrape_profile_page(profile_url)
    # html = open('https://learn-co-curriculum.github.io/student-scraper-test-page/students/eric-chu.html')
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    hash = {}
		#   twitter: nil,
		#   linkedin: nil,
		#   github: nil,
		#   blog: nil,
		#   profile_quote: nil,
		#   bio: nil
		# }

    links = doc.css('.social-icon-container a').map {|a| 
    	link = a.attribute('href').value
    }

    links.each {|link| sorts_social_link(hash, link)}

    hash[:profile_quote] = doc.css('.profile-quote').text
    hash[:bio] = doc.css('.description-holder p').text

    hash
  end

  def self.sorts_social_link(hash, link)
    if link.include?('twitter')
    	hash[:twitter] = link
    elsif link.include?('linkedin')
    	hash[:linkedin] = link
    elsif link.include?('github')
    	hash[:github] = link
    else
    	hash[:blog] = link
    end
  end

end

