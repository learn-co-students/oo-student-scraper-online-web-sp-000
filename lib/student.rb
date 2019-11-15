class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  # initializes a new student based on the student_hash, and adds that student to the @@all array.
  def initialize(student_hash)
    student_hash.each{|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  # iterates over a students_array of hashes and creates a new student from each hash.
  def self.create_from_collection(students_array)
    students_array.each{|student_hash| self.new(student_hash)}
  end

  # iterates through a attributes_hash and assigns those attributes and values to the students created.
  def add_student_attributes(attributes_hash)
    attributes_hash.each{|key, value| self.send(("#{key}="), value)}
    self
  end

  # accesses the @@all array.
  def self.all
    @@all
  end
end
