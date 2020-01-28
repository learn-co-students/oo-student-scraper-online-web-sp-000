class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  # takes in an argument of a hash and sets that new student's
  # attributes using the key/value pairs of that hash.
  def initialize(student_hash)
    # @name = student_hash[:name]
    # @location = student_hash[:location]
    student_hash.each do |k, v|
      self.send(("#{k}="), v)
    end
    @@all << self
  end

  # iterate over the array of hashes and create a new individual student using each hash.
  # => [{:name=>"Alex Patriquin", :location=>"New York, NY"},
     # {:name=>"Bacon McRib", :location=>"Kansas City, MO"},
     # {:name=>"Alisha McWilliams", :location=>"San Francisco, CA"},
     # {:name=>"Daniel Fenjves", :location=>"Austin, TX"},
     # {:name=>"Arielle Sullivan", :location=>"Chicago, IL"},
     # {:name=>"Sushanth Bhaskarab", :location=>"Portland, OR"},
     # {:name=>"Sushanth Bhaskarab", :location=>"Portland, OR"}]

  def self.create_from_collection(students_array)
    students_array.each do |new_student|
      self.new(new_student)
    end
  end

  # iterate over the given hash and use meta-programming to dynamically assign
  # the student attributes and values per the key/value pairs of the hash.
  # Use the #send method to achieve this.
  # The return value of this method should be the student itself. Use the self keyword.
  def add_student_attributes(attributes_hash)
    attributes_hash.each do |k, v|
      self.send(("#{k}="), v)
    end
  end

  def self.all
    @@all
  end
end
