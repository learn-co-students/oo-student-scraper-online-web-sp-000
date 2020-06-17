class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    
    student_hash.each_key do |key, value|
      self.send("#{key}=", student_hash[key])
    end

    @@all << self

  end

  def self.create_from_collection(students_array)
    students_array.each {|student|
    person = Student.new(student)}
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each_key do |key, value|
      self.send("#{key}=", attributes_hash[key])
    end
  end

  def self.all
    @@all
  end
end

