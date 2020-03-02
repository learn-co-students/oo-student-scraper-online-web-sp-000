require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_html = Nokogiri::HTML(open(index_url))
    self.save_student_info_to_hash(index_html)
  end

  def self.scrape_profile_page(profile_url)
    index_html = Nokogiri::HTML(open(profile_url))
    self.build_profile_hash(index_html)
  end



  private_class_method
#***************************************************************
    #helper functions for self.scrape_profile_pag
#***************************************************************
  def self.build_profile_hash(index_html)
    #Merge all social media hashes into one first
    link_hash =self.build_link_hash_array(index_html).reduce({}, :merge)
    #merge with profile hash and bio hash
    link_hash.merge(self.get_profile_qoute(index_html)).merge(self.get_profile_description(index_html))
  end

  def self.build_link_hash_array(index_html)
    array_link = []
    self.get_media_links(index_html).each do |link|
      if link.include?("twitter")
        array_link.push({ :twitter => link })
      elsif link.include?("linkedin")
        array_link.push({ :linkedin => link }) 
      elsif link.include?("github")
        array_link.push({ :github => link })
      else
        array_link.push({ :blog => link })
      end
    end
    array_link
  end

  def self.get_media_links(index_html)
    index_html.css("div .social-icon-container a").collect do |social|
      social["href"]
    end
  end

  def self.get_profile_qoute(index_html)
    profile_quote = {}
    index_html.css("div .vitals-text-container").each do |attrs|
       profile_quote = { :profile_quote => attrs.css("div.profile-quote").text }
    end
    profile_quote
  end

  def self.get_profile_description(index_html)
    {:bio => index_html.css("div .details-container div .description-holder p").text }
  end

#***************************************************************
    #helper functions for self.scrape_index_page
#***************************************************************
  def self.save_links_to_array(index_html)
    links = []
    index_html.css(".roster-cards-container a").each do |profile|
      links.push(profile["href"])
    end
    links
  end

  def self.save_student_info_to_hash(index_html)
    self.extract_info(grab_text_from_links(index_html), index_html)
  end

  def self.grab_text_from_links(index_html)
    student_web_info = []
    index_html.css(".roster-cards-container a").each do |profile|
      student_web_info.push(profile.text)
    end
    student_web_info
  end

  def self.extract_info(student_info, index_html)
    formatted_info = []
    #get rid of blank spaces
    student_info_array = student_info.collect { |info| info.split(" ")}
    
    # get rid of unnecessary entries
    student_info_array.each do |info|
      formatted_info << info.slice(2, 7)
    end
    
    links = self.save_links_to_array(index_html)
    build_student_hash(formatted_info, links)
  end

  def self.build_student_hash(student_info, links)
    student_info_array = []
    #use current index to access information in links array which has all the links
    #student-info has an array of all the information with name and location
    student_info.each_with_index do |info, index|
      name = info[0].to_s + " " + info[1].to_s
      location = info[2].to_s + " " + info[3].to_s + " " + info[4].to_s
      student_info_array.push({ :name => name, :location => location, :profile_url => links[index] })
    end
    student_info_array
  end
end


# def create_project_hash
#   projects = {}
#   kickstarter = Nokogiri::HTML(File.read('fixtures/kickstarter.html'))
#   kickstarter.css("#projects_list").each do |p_list|
#     p_list.css("li").each do |l|
#       title = l.css("h2.bbcard_name strong a").text
#       #was getting a nil entry from file
#       next if title.length == 0 
#       image_link = l.css("div.project-thumbnail a img").attribute("src").value
#       description = l.css("p.bbcard_blurb").text
#       location = l.css("ul.project-meta li a").text
#       percent_funded = l.css("ul.project-stats li strong").text.gsub("%","").to_i
#       projects[title.to_sym] = { :image_link => image_link,
#                                  :description => description,
#                                  :location => location,
#                                  :percent_funded => percent_funded }
#     end
#   end
#   # binding.pry
#   projects
# end
