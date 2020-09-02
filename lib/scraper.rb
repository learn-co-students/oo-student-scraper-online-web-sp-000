require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
# raise index_url
    #   #scrape_index_page
    #     is a class method that scrapes the student index page ('./fixtu
    # res/student-site/index.html') and a returns an array of hashes in w
    # hich each hash represents one student (FAILED - 1)
    scraped_students = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    test=doc.css(".student-card")
    # binding.pry
    test.each do |a|
      name = a.css(".student-name").text
      location = a.css(".student-location").text
      profile_url = a.css("a")[0]["href"]
      # puts profile_url
      hash = {
        :name => name,
        :location => location,
        :profile_url => profile_url
       }
      scraped_students.push(hash)
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    #   #scrape_profile_page
    #     is a class method that scrapes a student's profile page and ret
    # urns a hash of attributes describing an individual student (FAILED
    # - 2)
    #     can handle profile pages without all of the social links (FAILE
    # D - 3)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    social=doc.css(".social-icon-container").css("a")
    twitter=""
    linkedin=""
    github=""
    blog=""
    i=0
    h=Hash.new
    social.each_with_index {|b,a|
      case social[i]["href"]
        when /twitter.com/
              h[:twitter]=social[i]["href"]
        when /linkedin.com/
              h[:linkedin]=social[i]["href"]
        when /github.com/
              h[:github]=social[i]["href"]
        else
              h[:blog]=social[i]["href"]
      end
      i+=1
    }
    h[:profile_quote]=doc.css(".profile-quote").text
    h[:bio]=doc.css(".bio-block").css(".description-holder").text.strip
    # puts twitter
    # puts linkedin
    # puts github
    # puts blog
    # puts profile_quote
    # puts bio
# # raise "test"
#     binding.pry
    h
  end

end

# Scraper
# Student
#   #new
#     takes in an argument of a hash and sets that new student's attr
# ibutes using the key/value pairs of that hash. (FAILED - 4)
#     adds that new student to the Student class' collection of all e
# xisting students, stored in the `@@all` class variable. (FAILED - 5
# )
#   .create_from_collection
#     uses the Scraper class to create new students with the correct
# name and location. (FAILED - 6)
#   #add_student_attributes
#     uses the Scraper class to get a hash of a given students attrib
# utes and uses that hash to set additional attributes for that stude
# nt. (FAILED - 7)
#   .all
#     returns the class variable @@all (FAILED - 8)
