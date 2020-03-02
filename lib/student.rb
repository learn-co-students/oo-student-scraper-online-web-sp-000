require 'open-uri'
require 'pry'
require 'nokogiri'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
      student_hash.each do |k, v|
      self.send(("#{k}="), v)

      @@all << self
      end
  end

  def self.create_from_collection(students_array)
    #parameters for this method are the outputs from Scraper.scrape_index_page (list of sweveral students' name, loc, and url)
    students_array.each do |student_name_loc_url|
      self.new(student_name_loc_url)
    end
  end

  def add_student_attributes(attributes_hash)
    #should iterate over the given hash and use meta-programming to
    #dynamically assign the student attributes and values per the key/value
    #pairs of the hash. Use the #send method to achieve this.
    attributes_hash.each do |k, v|
        self.send(("#{k}="), v)
        #normal syntax for the send method is .send(method , param) and the k
        #represents the attr_accesor methods we defined up top
        @@all << self
    end

    return self
  end

  def self.all
    @@all
  end
end
