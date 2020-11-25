class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    #@location = student_hash[:location]
    # @name = student_hash[:name]
    # @@all << self
  end

  def self.create_from_collection(students_array)
    #will call students_array
    #will call Scraper.scrape_index_page
  end

  def add_student_attributes(attributes_hash)

  end

  def self.all

  end
end
