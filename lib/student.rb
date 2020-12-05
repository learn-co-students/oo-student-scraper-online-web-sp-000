require "pry"

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    assign_values(student_hash)
    @@all << self
    @name = name
    @location = location
  end

  def assign_values(values)
    values.each_key do |k, v|
      self.send("#{k}=", values[k])
    end
  end

  def self.create_from_collection(students_array)
    students_array.each do |hash|
      self.new(hash)
    end
  end

  def add_student_attributes(attributes_hash)
    self.assign_values(attributes_hash)
    # if hash includes name then assign values
  end

  def self.all
    @@all
  end
end
