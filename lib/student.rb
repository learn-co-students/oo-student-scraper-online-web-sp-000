class Student
  #uses info returned by scraper.rb methods to create students and add attributes to individual students
  #student class and scraper class don't direclty interact--shouldn't call on Scraper class in any methods--keeps program flexible
  #simply is ready to take in information, regardless of its source
  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
   
    #use meta programming to assign new student attributes and values per key/value pairs of hash. Use #send method to achieve this
    #add newly created student to @@all
    @@all << self
  end

  def self.create_from_collection(students_array)
    #takes in array of hashes 
    #iterates over array of hashes to create new student using each hash
  end

  def add_student_attributes(attributes_hash)
    #take hash whose key/value pairs describe additional attributes of a student
    #iterate over hash and use metaprogramming to dynamically assign student attributes and values using #send method
    #return value should be student, or self
  end

  def self.all
    @@all
  end
end

