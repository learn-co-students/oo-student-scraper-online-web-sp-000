class Student           #class that uses that data to instantiate new objects.

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each do |attribute, value|
      self.send("#{attribute}=", value)    #send instance method metaprograms to assign the newly created student attributes and values in accordance with the key/value pairs of the hash.
    end
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student_hash|
      Student.new(student_hash)
    end
  end

  #iterate over the given hash and use metaprogramming to dynamically assign the student attributes
  #and values in accordance with the key/value pairs of the hash.
  def add_student_attributes(attributes_hash)
    attributes_hash.each do |attr, value|
      self.send("#{attr}=", value)
    end
    return self
  end

  def self.all
    return @@all
  end
end
