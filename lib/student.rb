require 'pry'
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

#Takes in an argument of a hash, uses metaprogramming to assign attributes + values
#Use the send method!
#Adds the new student to the @@al array of students with push self
  def initialize(student_hash)
    student_hash.each {|k, v| self.send(("#{k}="), v)}
    @@all << self
  end

#Takes in an array of hashes, then iterates over the array and creates a new individual student
  def self.create_from_collection(students_array)
    students_array.each do |student_info|
      self.new(student_info)
      # binding.pry
    end
  end

#Takes in a hash of whose key/value pairs describe additional attributes of an indivual student
#Iterates over given Scraper.scrape_profile_page, uses metaprogramming to assign attributes
#and values.
#Use the send method
#The return value should be the student itself. use the self keyword.
  def add_student_attributes(attributes_hash)
    attributes_hash.each do |k,v|
      self.send(("#{k}="), v)
  end
  self
end

#Returns the contents of @@all array
  def self.all
    @@all
  end
end
