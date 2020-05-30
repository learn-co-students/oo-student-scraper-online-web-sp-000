require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html")
    doc = Nokogiri::HTML(html)
    student = [] 
     
     doc.css("div.roster-cards-container").each do |name| 
       name.css("div.student-card").each do |i|
        name = i.css("h4").text
        location = i.css("p").text
        profile_url = i.css("a").attribute("href").text
          #  binding.pry
        student << { :name => name, :location => location, :profile_url => profile_url }
      #  binding.pry  
      end  
      
        # puts name.text.strip
      end
      student
      #  binding.pry
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    keys = [:twitter, :linkedin, :github, :blog, :profile_quote, :bio]
    hash = {}
    keys.each{|key| hash[key]}
    doc.css("div.vitals-container").each do |vitals|
        vitals.css("div.social-icon-container").each do |ref|
          ref.css("a").each do |a|
            name = vitals.css("div.vitals-text-container h1").text  
            name = name.split(" ")
            name = name[0].downcase
            href = a.values
                domain = href[0].split(".com")
              href = href[0]
            # binding.pry
            if domain[0].include?("www.")
              domain = domain[0].split("www.")
            else
              domain = domain[0].split("//")
            end
            domain = domain[1]     
            domain = domain.to_sym
            if keys.include?(domain)
            hash[domain] = href  
            elsif href.include?(name)
              hash[:blog] = href
            end
            profile_quote = vitals.css("div.vitals-text-container div.profile-quote").text
            hash[:profile_quote] = profile_quote
            # binding.pry

          end
          
        end
        
      
   
    end
    doc.css("div.details-container").each do |item|
      biography = item.css("p").text
      hash[:bio] = biography
    end
    hash
  end   
   

end

