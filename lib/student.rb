class Student

  @@all = []
  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

#when set to private, breaks tests because CLI.rb calls on this in application process
    def add_student_attributes(attributes_hash)
      attributes_hash.each {|key, value| self.send("#{key}=", value)}
    end

#experimenting with privacy in ruby
#all of the following work in house and arent called on student excpet internally
    private
    def self.create_from_collection(students_array)
      students_array.each {|stu| Student.new(stu)}
    end

    def save
      @@all << self
    end

    def self.all
      @@all
    end

    def initialize(student_hash)
      student_hash.each {|k,v| self.send("#{k}=", v)}
      save
    end

end
