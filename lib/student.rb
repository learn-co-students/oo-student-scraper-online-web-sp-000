class Student
  attr_accessor :name
  attr_accessor :location
  attr_accessor :twitter
  attr_accessor :linkedin
  attr_accessor :github
  attr_accessor :blog
  attr_accessor :bio
  attr_accessor :profile_quote
  attr_accessor :profile_url

  @@all = []

  def initialize(student_hash)
    @@all << add_student_attributes(student_hash)
  end

  def self.create_from_collection(students_array)
    students_array.map {|student| self.new(student)}
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send("#{key}=", value)}
    self
  end

  def self.all
    @@all
  end
end