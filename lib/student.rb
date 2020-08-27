class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    #using metaprogramming. aka the send method
    student_hash.each do | key, value |
      self.send( "#{key}=", value)
    end # end iteration
    @@all << self #self = instance
  end

  def self.create_from_collection(students_array) #CLASS method
    #This class method should take in an array of hashes, each hash is a student
    # it will iterate over the array, simply feed the hash as argument to the initialize method to create a new Student instance,
    students_array.each do | studenthash |
      self.new(studenthash)
    end #end iteration

  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do | key, value |
      self.send( "#{key}=", value)
    end # end iteration
    return self
  end

  def self.all
    @@all
  end
end
