class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |e|
    self.all << self.new(e)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |k, v|
      # binding.pry
      self.send("#{k}=", attributes_hash[k])
    end
  end

  def self.all
    @@all
  end
end

