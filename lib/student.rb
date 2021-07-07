require_relative '../lib/concerns/memorable'

class Student
  extend Memorable::ClassMethods
  include Memorable::InstanceMethods

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each{|key, value| self.send(("#{key}="), value)}
    self.class.all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      newstudent = Student.new(student)
      newstudent.save
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each{|key, value| self.send(("#{key}="), value)}
  end

  def self.all
    @@all
  end

end
