class Student
  #uses info returned by scraper.rb methods to create students and add attributes to individual students
  #student class and scraper class don't direclty interact--shouldn't call on Scraper class in any methods--keeps program flexible
  #simply is ready to take in information, regardless of its source
  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
   student_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      Student.new(student)
  end
end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send(("#{key}="), value)}
  end

  def self.all
    @@all
  end
end

