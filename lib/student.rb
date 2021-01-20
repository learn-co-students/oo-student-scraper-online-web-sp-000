require 'pry'
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []
  
  
  def initialize(student_hash) #the student hash was created already, it will be given to this method 
    @name = student_hash[:name] #connect the name to the @name 
    @location = student_hash[:location]
    @@all << self 
    #binding.pry
  end

  def self.create_from_collection(students_array)
    students_array.each{|student| student = self.new(student)}
  end


  def add_student_attributes(attributes_hash)
    @twitter = attributes_hash[:twitter] #connect the attributes to the person 
    @linkedin = attributes_hash[:linkedin]
    @github = attributes_hash[:github]
    @blog = attributes_hash[:blog]
    @profile_quote = attributes_hash[:profile_quote]
    @bio = attributes_hash[:bio]
    #binding.pry
  end

  def self.all
    @@all 
  end
  
end

