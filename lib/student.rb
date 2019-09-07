class Student
  # class User
  #   attr_accessor :name, :user_name, :age, :location, :bio
  #
  #   def initialize(attributes)
  #     attributes.each {|key, value| self.send(("#{key}="), value)}
  #   end
  # end
  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each do |key, value|
      self.send(("#{key}="), value)
    end
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student_hash|
      Student.new(student_hash)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.send(("#{key}="), value)
    end
    self
  end

  def self.all
    @@all
  end
end
