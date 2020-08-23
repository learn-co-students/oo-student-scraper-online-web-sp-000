class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []
  # assigns the newly created student attributes and values per the key/value pairs of the hash
  def initialize(student_hash)
    student_hash.each {|k, v| self.send(("#{k}="), v)}
    @@all << self
  end

  # iterate over the array of hashes and create a new individual student using each hash
  def self.create_from_collection(students_info)
    students_info.each do |student_hash|
      self.new(student_hash) 
    end
  end

    # take in a hash whose key/value pairs describe additional attributes of an individual student
  def add_student_attributes(attributes_hash)
    attributes_hash.each do |k,v|
      self.send(("#{k}="), v)
    end
  end

  def self.all
    @@all
  end
end

