class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each do |key, value|
      if key == :name
        @name = value
      else key == :location
        @location = value
      end
    end
    @@all << self
  end

  def self.create_from_collection(students_array)
    #for each student in the array, retrieve the name and location k v pair and assign
    students_array.each do |student|
      new_student = Student.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      if  key == :twitter
        @twitter = value
      elsif key == :linkedin
        @linkedin = value
      elsif key == :github
        @github = value
      elsif key == :blog
        @blog = value
      elsif key == :profile_quote
        @profile_quote = value
      elsif key == :bio
        @bio = value
      else :profile_url
        @profile_url = value
      end
    end
  end

  def self.all
    @@all
  end
end
