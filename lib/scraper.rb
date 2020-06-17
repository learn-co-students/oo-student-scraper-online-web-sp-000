require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    
    doc = Nokogiri::HTML(open(index_url))
    #binding.pry
    @student_hash = []
    @all_student_front_profile = doc.css(".student-card")
    #@all_student_names = doc.css("h4.student-name")
    #binding.pry
    @all_student_front_profile.each {|student|
    #binding.pry
      @student_hash << {:name => student.css(".student-name").text,
                        :location => student.css(".student-location").text,
                        :profile_url => student.css("a/@href").first.value
      }

    }
    @student_hash
  end

  def self.scrape_profile_page(profile_url)
    @student_profile_hash = {}
    doc = Nokogiri::HTML(open(profile_url))
    @student_links = doc.css(".social-icon-container").css("a/@href")
    
    @student_links.each {|link|
      if link.value.include?("linkedin")
        @student_profile_hash[:linkedin] = link.value
      elsif link.value.include?("twitter")
        @student_profile_hash[:twitter] = link.value
      elsif link.value.include?("github")
        @student_profile_hash[:github] = link.value
      else
        @student_profile_hash[:blog] = link.value
      end
      #binding.pry
    }
    # @student_profile_hash[:twitter] = doc.css(".social-icon-container").css("a/@href")[0].value
    # @student_profile_hash[:linkedin] = doc.css(".social-icon-container").css("a/@href")[1].value
    # @student_profile_hash[:github] = doc.css(".social-icon-container").css("a/@href")[2].value
    # @student_profile_hash[:blog] = doc.css(".social-icon-container").css("a/@href")[3].value
    @student_profile_hash[:profile_quote] = doc.css(".profile-quote").text
    if doc.css(".description-holder p")[0] == nil
    else
      @student_profile_hash[:bio] = doc.css(".description-holder p")[0].text
    end
    
    #binding.pry
    @student_profile_hash
  end

end

