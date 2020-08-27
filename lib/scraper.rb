require 'open-uri'
require "nokogiri"
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    #Goal: we watn this method to return an array of hashes, each hash represent one student
    doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/"))
    #all student cards have the div class="student-card"
    #down one level u have the a href, we want that href attributes
    #down another level we have div class card-text-container
    #inside that we want <h4 class="student-name"
    #and <p class student-location
    xmlnodeset = doc.css(".student-card") #this should give me an "nodeset" of all those student card items
    # doc.css(".student-card")[0] #this gives me the first student card
    #when we execute, we loop thru, so lets pretend we're working on just one item at a time
    #when u extract an element with css, u can further do css on top of it! like chaining.
    # doc.css(".student-card")[0].css("a").attribute("href").value
    # doc.css(".student-card")[0].css("a .card-text-container .student-name").text
    # doc.css(".student-card")[0].css("a .card-text-container .student-location").text
    arrayofhashes = []
    xmlnodeset.each do | student |
      arrayofhashes << {
        :name => student.css("a .card-text-container .student-name").text,
        :location => student.css("a .card-text-container .student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end #end iteration
    arrayofhashes
  end #end method

  def self.scrape_profile_page(profile_url)
    #takes one url at a time

    doc = Nokogiri::HTML(open(profile_url))
    #doc.css(".vitals-container .social-icon-container a")[0].attribute("href").value
    #how to sort which website is a bit difficult. cuz its not labeled. the number of link varies person to person

    #doc.css(".bio-content .description-holder p").text

    #doc.css(".profile-quote").text
    personhash = {
      :bio => doc.css(".bio-content .description-holder p").text,
      :profile_quote => doc.css(".profile-quote").text
    }

    linksnodeset = doc.css(".vitals-container .social-icon-container a")
    linksnodeset.each do | link |

      if link.attribute("href").value.include?("twitter.com")
        personhash[:twitter] = link.attribute("href").value
      elsif link.attribute("href").value.include?("linkedin.com")
        personhash[:linkedin] = link.attribute("href").value
      elsif link.attribute("href").value.include?("github.com")
        personhash[:github] = link.attribute("href").value
      else
        personhash[:blog] = link.attribute("href").value
      end #end if else



    end #end iteration
    personhash
  end

end
