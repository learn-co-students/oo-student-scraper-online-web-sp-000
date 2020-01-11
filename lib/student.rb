class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    # takes in an arg of a hash and sets that new student's
    # attributes using the key/value pairs of that hash
    student_hash.each {|key, value| self.send(("#{key}="), value)}
    save
  end

  def save
    @@all << self
  end

  def self.create_from_collection(students_array)
    # uses the Scraper class to create students with
    # the correct name and location
    # iterate over the array of hashes and create a new individual
    # student using each hash.
    students_array.each do |student|
      Student.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    # takes in a hash whose key/value pairs describe additional attributes of an individual student
    # iterate over the given hash and use meta-programming to dynamically
    # assign the student attributes and values per the key/val pairs of the hash.
    # use #send
    attributes_hash.each do |attribute, value|
      self.send(("#{attribute}="), value)
      save
    end
  end

  def self.all
    @@all
  end
end
