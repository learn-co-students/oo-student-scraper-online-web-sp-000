class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(hash)
    add_student_attributes(hash)
    @@all << self
  end

  def self.create_from_collection(array)
    array.each do |x|
      Student.new(x)
    end
  end

  def add_student_attributes(hash)
    @name = hash[:name]
    @location = hash[:location]
    @twitter = hash[:twitter]
    @linkedin = hash[:linkedin]
    @github = hash[:github]
    @blog = hash[:blog]
    @profile_quote = hash[:profile_quote]
    @bio = hash[:bio]
    @profile_url = hash[:profile_url]
  end

  def self.all
    @@all
  end
end
