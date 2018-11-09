class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
      student_hash.each do |key, val|
          ##stackoverflow.com/questions/973452/calling-self-send-iteratively-on-a-hash-argument-to-initialize
          self.send "#{key}=", val
      end
      @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |stu|
        Student.new(stu)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, val|
        self.send "#{key}=", val
    end
  end

  def self.all
    @@all
  end
end

