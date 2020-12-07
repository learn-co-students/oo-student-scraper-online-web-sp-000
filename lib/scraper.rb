require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :index_site, :profile_site

  def self.scrape_index_page(index_url)
    @index_site = Nokogiri::HTML(open(index_url))
    students = []
    locations = get_locations
    profile_urls = get_profile_urls
    get_names.each_with_index do |name, i|
      loc = locations[i]
      p_url = profile_urls[i]
      student = {name: name, location: loc, profile_url: p_url}
      students << student
    end
    students
  end

  def self.get_names
    names = []
    @index_site.css(".roster-cards-container").css("h4").css(".student-name").each do |card|
      names << card.text
    end
    names
  end

  def self.get_locations
    locations = []
    @index_site.css(".roster-cards-container").css("p").css(".student-location").each do |card|
      locations << card.text
    end
    locations
  end

  def self.get_profile_urls
    # @index_site = Nokogiri::HTML(open(index_url))
    profile_urls = []

    get_names.each_with_index do |s|
      url = "students/#{s.split(" ").first.downcase}-#{s.split(" ").last.downcase}.html"

      profile_urls << url

    end

    profile_urls
  end

  def self.scrape_profile_page(profile_url)

# **************************************************
# binding.pry
# **************************************************


    @profile_site = Nokogiri::HTML(open(profile_url))

    student = {}

    p = @profile_site.css("a")

    p.each do |el|
      if el.attr("href").include? "twitter"
        student[:twitter] = el.attr("href")
      elsif el.attr("href").include? "linkedin"
        student[:linkedin] = el.attr("href")
      elsif el.attr("href").include? "github"
        student[:github] = el.attr("href")
      elsif el.attr("href").match(/^[https]/.to_s)
        student[:blog] = el.attr("href")
      end
    end

    # p.each_with_index do |el, i|
    #   if p[i].attr("href").include? "twitter"
    #     student[:twitter] = p[i].attr("href")
    #   elsif p[i].attr("href").include? "linkedin"
    #     student[:linkedin] = p[i].attr("href")
    #   elsif p[i].attr("href").include? "github"
    #     student[:github] = p[i].attr("href")
    #   elsif p[i].attr("href").match(/^http/.to_s)
    #     student[:blog] = p[i].attr("href")
    #   end
    # end

    if @profile_site.css("div.vitals-text-container")
      student[:profile_quote] = "\"#{@profile_site.css("div.vitals-text-container").text.split(/\"/)[1]}\"#{@profile_site.css("div.vitals-text-container").text.split(/\"/)[2]}".strip
    end
    
    if @profile_site.css("div.description-holder").first
      student[:bio] = @profile_site.css("div.description-holder").first.text.split("\n")[1].strip
    end

    student
  end

end



# **************************************************
# binding.pry
# **************************************************

