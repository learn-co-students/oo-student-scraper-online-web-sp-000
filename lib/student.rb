class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @twitter = student_hash[:twitter]
    @linkedin = student_hash[:linkedin]
    @github = student_hash[:github]
    @blog = student_hash[:blog]
    @profile_quote = student_hash[:profile_quote]
    @bio = student_hash[:bio]
    @profile_url = student_hash[:profile_url]

    @@all << self

  end

  def self.create_from_collection(students_array)

    students_array.each_with_index do |student, index|
      new_student = Student.new(students_array[index])
      @@all << new_student
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      if key.to_s == "name"
        @name = value
      elsif key.to_s == "location"
        @location = value
      elsif key.to_s == "twitter"
        @twitter = value
      elsif key.to_s == "linkedin"
        @linkedin = value
      elsif key.to_s == "github"
        @github = value
      elsif key.to_s == "blog"
        @blog = value
      elsif key.to_s == "profile_quote"
        @profile_quote = value
      elsif key.to_s == "bio"
        @bio = value
      elsif key.to_s == "profile_url"
        @profile_url = value
      end
    end

  end

  def self.all
    @@all
  end
end
