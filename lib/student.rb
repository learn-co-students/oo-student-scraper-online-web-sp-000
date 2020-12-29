class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
    
  end

  def self.create_from_collection(students_array)
    #binding.pry
    students_array.each do |student| 
       if (student[:profile_url])
         scrapped_hash = Scraper.scrape_profile_page(student[:profile_url])
          student.merges(scrapped_hash)
      end
      self.new(student)
    end
    
    
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send(("#{key}="), value)}
  end

  def self.all
    @@all
  end
end

