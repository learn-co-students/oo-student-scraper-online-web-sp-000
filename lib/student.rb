class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash) #student_hash es un hash individual resultado del method Scraper.scrape_index_page, los keys eran :name, :location y :profile_url
    student_hash.each {|k,v| self.send(("#{k}="),v)}
    @@all << self
  end

  def self.create_from_collection(students_array) # student_array es el resultado del method Scraper.scrape_index_pag
    students_array.each{|student_hash| Student.new(student_hash)}
  end

  def add_student_attributes(attributes_hash) #attributes_hash es el resultado de Scrape.scrape_profile_page, los keys eran :linkedin, :github...
    attributes_hash.each{|k,v| self.send(("#{k}="),v)}
    self
  end

  def self.all
    @@all
  end
end
