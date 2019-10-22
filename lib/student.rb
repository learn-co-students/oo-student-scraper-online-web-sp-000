require 'pry'
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash) # We pass in the array as soon as we make a new student.
    @name = student_hash[:name] # We extract the value from our name key in the hash.
    @location = student_hash[:location] # We extract the value from our location key in the hash.

    @@all << self # We save each instance of the student in our '@@all array'
  end

  def self.create_from_collection(students_array)
    #binding.pry
    students_array.each do |info| # This method iterates over our students array, selecting out each hash.
        Student.new(info) # We then take this hash and plug it into our initialize method, creating a new student for each instance.
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key,value| self.send(("#{key}="), value)}
  end

  def self.all
    @@all
  end
end
