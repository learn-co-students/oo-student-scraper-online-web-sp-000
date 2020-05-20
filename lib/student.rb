require 'pry'
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash.values[0]
    @location = student_hash.values[1]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each {|student| self.new(student)}
  end

  def add_student_attributes(attributes_hash)
    array = attributes_hash.to_a
    array.each do |key_value|
      if key_value.include?(:twitter)
        @twitter = key_value[1]
      elsif key_value.include?(:linkedin)
        @linkedin = key_value[1]
      elsif key_value.include?(:github)
        @github = key_value[1]
      elsif key_value.include?(:blog)
        @blog = key_value[1]
      elsif key_value.include?(:profile_quote)
        @profile_quote = key_value[1]
      elsif key_value.include?(:bio)
        @bio = key_value[1]
      end
    end
  end

  def self.all
    @@all
  end
end
