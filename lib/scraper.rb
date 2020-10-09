require 'open-uri'
require 'pry'
require 'nokogiri'
#The Trifecta of Useful Gems


class Scraper
  
  def self.scrape_index_page(index_url)
    roster = []
    doc = Nokogiri::HTML(open(index_url))
    #Doc variable = UseTheNokogiriGem::OnThisHTMLPage(open[use open-uri to open]("This URL, which can also be fed in via argument"))
    doc.css(".student-card").each do |student|
      hash = {:name => student.css(".card-text-container h4.student-name").text, 
      :location => student.css(".card-text-container p.student-location").text, 
      :profile_url => student.css("a").attribute("href").value }
      #doc.css calls teh whole thing again, student.css calls the individual array item!!
      #student_name = [array variable name].css(".student-name").text
      #student_location = [array variable name].css(".student-location").text
      #":profile_url" => student.css("a").attribute("href").value
      roster << hash
    end
    roster 
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    doc = Nokogiri::HTML(open(profile_url))
    #Here is the doc! This is a great place to put a pry because then you can figure out all the 
    #various css classes from here.
    
    array = doc.css(".social-icon-container").children.css("a").map {|el| el.attribute('href').value}
      #All the social media is in the .social-icon-container div class
      #Pushing it into an array for ease of manipulation
      #Pulling from the social icon container and specifically MARKING THE CHILDREN
      #Iterating each child and pulling out the href value
      #No I don't know why this worked better but it did.

      array.each do |data|
        #Then iterate over the array to manipulate it into the hash
      if data.include?("linkedin") 
        student[:linkedin] = data
      elsif data.include?("twitter") 
        student[:twitter] = data
      elsif data.include?("github") 
        student[:github] = data
      else 
        student[:blog] = data
      end 
      #If each element of the social-icon-container includes the required word in the url
      #Then push that to the appropriate key in the student hash
      #The blog is the odd one out, so it's the final else 
      #If you can't find a place for it otherwise, it's the blog.
    end

    student[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text
    student[:bio] = doc.css(".details-container .description-holder p").text
    #And then there's these stinkers that aren't in the social icon container and has to be picked out
    #Fortunately you only need the overall container, the most specific container, and then the HTML tag.text
    student
    #DON'T FORGET TO RETURN THE HASH.
  end

end
