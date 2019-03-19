class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio 
  
  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self 
    
  end

  def self.create_from_collection(students_array)
    count = 0
    students_array.each do |s|
    student = self.new(students_array[count])
    count += 1
  end
  
  end

  def add_student_attributes(attributes_hash)
  
  attributes_hash.each do |key, value|
  self.send("#{key}=", value)
    end

  end

  def self.all
    @@all 
  end
  
  
end

