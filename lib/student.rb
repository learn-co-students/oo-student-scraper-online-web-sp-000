class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each{|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_collection(students_array)#passes in an array of hashes from scraper.rb with name, location, and profile
    students_array.each{|student| Student.new(student)}
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |k, v|
      if k == :twitter then self.twitter = v
      end
      if k == :linkedin then self.linkedin = v
      end
      if k == :github then self.github = v
      end
      if k == :blog then self.blog = v
      end
      if k == :profile_quote then self.profile_quote = v
      end
      if k == :bio then self.bio = v
      end
    end
  end

  def self.all
    @@all
  end
end
