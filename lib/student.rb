class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self 
    student_hash = self 
    
  end

  #create new students with correct name and location 
  def self.create_from_collection(students_array)
     students_array.each do |student|
         student = self.new(student)
    end
    
  end

  def add_student_attributes(attributes_hash)
    @twitter = attributes_hash[:twitter]
    @github = attributes_hash[:github]
    @linkedin = attributes_hash[:linkedin]
    @blog = attributes_hash[:blog]
    @bio = attributes_hash[:bio]
    @profile_quote = attributes_hash[:profile_quote]
    
  end

  def self.all
    @@all 
  end
end

