class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    # takes in an arg of a hash and sets that new student's
    # attributes using the key/value pairs of that hash.
    # binding.pry
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
    #binding.pry
    students_array.each do |student|
      Student.new({:name => "#{student[:name]}", :location => "#{student[:location]}"})
    end
    #binding.pry
  end

  def add_student_attributes(attributes_hash)

  end

  def self.all

  end
end
