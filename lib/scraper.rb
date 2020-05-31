require 'nokogiri'
require 'open-uri'
require 'pry'


class Scraper
  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []

    doc.css(".student-card").each do |student|
      student_hash= {}
      student_hash[:name] = student.css(".student-name").text.strip
      student_hash[:location] = student.css(".student-location").text.strip
      student_hash[:profile_url] = student.css("a[href]").first['href']

# array_of_arrays.each
# { |record| array_of_hashes << {'name' => record[0], 'number' => record[1].to_i, 'email' => record[2]} }


      students << student_hash
      # binding.pry

    end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
