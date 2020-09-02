class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
# binding.pry
# puts student_hash[":name"]
    @name=student_hash[:name]
    @location=student_hash[:location]
    @profile_url=student_hash[:profile_url]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each {|a|
      self.new(a)
    }
  end

  def add_student_attributes(attributes_hash)
    @twitter=attributes_hash[:twitter]
    @linkedin=attributes_hash[:linkedin]
    @bio=attributes_hash[:bio]
    @blog=attributes_hash[:blog]
    @profile_quote=attributes_hash[:profile_quote]
    # binding.pry
  end

  def self.all
    @@all
  end
end
