require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))

    index_page.css("div.student-card").collect do |card|
      {:name => card.css("h4.student-name").text.strip,
      :location => card.css("p.student-location").text.strip,
      :profile_url => card.css("a").attribute("href").value}
    end
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))

    student_hash = Hash.new(0)

    links = profile_page.css("div.social-icon-container a")  

    twitter_link = ''
    linkedin_link = ''
    github_link = ''
    blog_link = ''

    links.each do |url|
      if url.attribute("href").value.start_with?("https://twitter.com/", "http://twitter.com/")
        twitter_link = url
      elsif url.attribute("href").value.start_with?("https://www.linkedin.com/", "http://www.linkedin.com/")
        linkedin_link = url
      elsif url.attribute("href").value.start_with?("https://github.com/", "http://github.com/")
        github_link = url
      end
    end

    if links.length == 4
      blog_link = links[3]
    end

    if twitter_link != ''
      student_hash[:twitter] = twitter_link["href"]
    end

    if linkedin_link != ''
      student_hash[:linkedin] = linkedin_link["href"]
    end

    if github_link != ''
      student_hash[:github] = github_link["href"]
    end

    if blog_link != ''
      student_hash[:blog] = blog_link["href"]
    end

    student_hash[:profile_quote] = profile_page.css("div.vitals-text-container div.profile-quote").text

    student_hash[:bio] = profile_page.css("div.details-container div.description-holder p").text

    student_hash
  end

end

