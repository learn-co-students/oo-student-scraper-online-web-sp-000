class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    # becuase you are getting attributes from a hash using the send method makes the most sense
    # iterate though the student_hash argument
    # use .send(""#{key=}", value")so you can assign each key to :name,:location, etc and gives them the correct value
    # then just put the object into the class variable all

    student_hash.each do |key,value|
      student_info.send("#{key=}, value")
    end
    @@all << self

  end

  def self.create_from_collection(students_array)
    # iterate through the argument a hash is passed into it
    # create a new student and put the iteration argument inside
    # since each object is initialized with that send method passing a collection assigns all the information that is needed
    # this can now create many objects with the correct information
  end

  def add_student_attributes(attributes_hash)
    # same as the initialize method but with a different argument name
  end

  def self.all
    # boi if you don't
    @@all

  end
end
