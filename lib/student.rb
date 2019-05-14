class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    self.name = student_hash[:name]
    self.location = student_hash[:location]
    self.class.all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |hash|
      Student.new(hash)
    end
  end

  def add_student_attributes(attributes_hash)
    self.twitter = attributes_hash[:twitter]
    self.github = attributes_hash[:github]
    self.linkedin = attributes_hash[:linkedin]
    self.blog = attributes_hash[:blog]
    self.profile_quote = attributes_hash[:profile_quote]
    self.bio = attributes_hash[:bio]
  end

  def self.all
    @@all
  end
end
