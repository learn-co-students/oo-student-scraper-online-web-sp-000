class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url
  require_relative './scraper.rb'#require_relative './course.rb'
  @@all = []

  def initialize(student_hash)
    student_hash.each {|k,v| self.send("#{k}=", v)}
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |hash|
      Student.new(hash)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|k, v| self.send("#{k}=", v)}
  end

  def self.all
    @@all
  end
end
#
# students_array.each do |student_hash| #each student is a hash
#     Student.new(student_hash)
