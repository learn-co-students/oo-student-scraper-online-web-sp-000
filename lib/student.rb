class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self
  end

  def self.create_from_collection(students_array) ##Each element of this array is one hash, gotta iterate over this array to acept each indidual student, and #Initialize will grab their names and locations

    students_array.each do |element| ## Now we're working with each hash and creating a new Student instance with the :Keys and "Values" of each hash.
      student = Student.new(element)
      student
    end
  end

  def add_student_attributes(attributes_hash)
    @bio = attributes_hash[:bio]
    @blog = attributes_hash[:blog]
    @linkedin = attributes_hash[:linkedin]
    @profile_quote = attributes_hash[:profile_quote]
    @twitter = attributes_hash[:twitter]

  end

  def self.all
    @@all
  end
end
