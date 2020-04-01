class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    hash_values(student_hash)
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each {|hash| self.new(hash)}
  end

  def add_student_attributes(attributes_hash)
    hash_values(attributes_hash)
  end
  
  def hash_values(hash)
    hash.each {|symbol, value| self.send(("#{symbol}="),value)}
  end

  def self.all
    @@all
  end
end

