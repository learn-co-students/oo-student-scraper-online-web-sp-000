require 'pry'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each{|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

# students_array
# => [{:name=>"Alex Patriquin", :location=>"New York, NY"},
# {:name=>"Bacon McRib", :location=>"Kansas City, MO"},
# {:name=>"Alisha McWilliams", :location=>"San Francisco, CA"},
# {:name=>"Daniel Fenjves", :location=>"Austin, TX"},
# {:name=>"Arielle Sullivan", :location=>"Chicago, IL"},
# {:name=>"Sushanth Bhaskarab", :location=>"Portland, OR"},
# {:name=>"Sushanth Bhaskarab", :location=>"Portland, OR"}]


  def self.create_from_collection(students_array)
    students_array.each do |student_hash|
      self.new(student_hash)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |k, v|
      self.send(("#{k}="), v)
    end
    self
  end

  def self.all
    @@all
  end
end

