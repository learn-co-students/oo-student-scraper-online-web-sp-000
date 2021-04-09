class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    #use meta-programming
    #send method

    student_hash.each {|k,v| self.send("#{k}=",v)}

    @@all << self
  end

  def self.create_from_collection(students_array)
    #iterate over array of hashes
    #create a new individual student using each hash

    students_array.each {|s| Student.new(s)}
  end

  def add_student_attributes(attributes_hash)

    attributes_hash.each {|k,v| self.send("#{k}=",v)}
  end

  def self.all
    @@all
  end
end

