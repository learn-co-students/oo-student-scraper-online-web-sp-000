class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    if student_hash.class == Hash
    student_hash.each_pair do |k, v| 
      instance_variable_set("@#{k}", v)
      self.class.instance_eval {attr_accessor k.to_sym}
      end
    end
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      student = self.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each_pair do |k, v| 
      instance_variable_set("@#{k}", v)
      self.class.instance_eval {attr_accessor k.to_sym}
    end
  end

  def self.all
    @@all
  end
end

