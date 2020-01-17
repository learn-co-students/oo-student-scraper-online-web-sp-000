require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  attr_accessor :doc, :index_url

  def initialize(index_url)
    @index_url = index_url
  end

  def self.scrape_index_page(index_url)
    html = open(index_url)
    @doc = Nokogiri::HTML(html)

    students = []
    @doc.css("div.roster-cards-container").each do |info|
    info.css(".student-card a").each do |a_student|
  #   student = Scraper.new

    each_student = {
        :name => a_student.css(".student-name").text,
        :location => a_student.css(".student-location").text,
        :profile_url => info.css(".student-card").first.css("a").attr("href").value
        # a_student.css("a").attr("href")
      
      }
      students << each_student
# binding.pry
        end
      end
      students
    end

        #   allstudent.each do |student|

          # @doc.css(".student-card").each do |student|

        #    student.each do |profile|
        #  profile = Student.new
             #scraped = student.css('.student_card').text
  #  students.css('div.a').first
  #  students.css('div.student-card a').each do |student|
  #@doc.css(".student-card").first.css("a").attr("href")
    #   end


  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
  end


end
