class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each {|key, value| self.send(("#{key}="), value)}

    @@all << self
  end

  def self.create_from_collection(students_array)
  #  The "students_array" is the return array from the "self.scrape_index_page(index_url)" method from the Scraper class.
  students_array.each {|info| Student.new(info)}
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send(("#{key}="), value)}
  end

  def self.all
    @@all

  end
end
