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
    students_array.each do |student|
      new_student = Student.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      if key == :bio
        @bio = value
      elsif key == :blog
        @blog = value
      elsif key == :linkedin
        @linkedin = value
      elsif key == :profile_quote
        @profile_quote = value
      elsif key == :twitter
        @twitter = value
      end
    end
  end

  def self.all
    @@all
  end
end
