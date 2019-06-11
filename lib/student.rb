require "pry"

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      @@new_student = self.new(student)
    end  
  @@new_student
  end

  def add_student_attributes(attributes_hash)




#     binding.pry
  end

  def self.all
    @@all
  end
  
end


=begin
=> {:twitter=>"someone@twitter.com",
 :linkedin=>"someone@linkedin.com",
 :github=>"someone@github.com",
 :blog=>"someone@blog.com",
 :profile_quote=>
  "\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
 :bio=>
  "I was in southern California for college (sun and In-n-Out!), rural Oregon for high school (lived in a town with 1500 people and 3000+ cows), and Tokyo for elementary/middle school."}

  describe "#add_student_attributes" do 
    it "uses the Scraper class to get a hash of a given students attributes and uses that hash to set additional attributes for that student." do 
      student.add_student_attributes(student_hash) 
      expect(student.bio).to eq("I was in southern California for college (sun and In-n-Out!), rural Oregon for high school (lived in a town with 1500 people and 3000+ cows), and Tokyo for elementary/middle school.")
      expect(student.blog).to eq("someone@blog.com")
      expect(student.linkedin).to eq("someone@linkedin.com")
      expect(student.profile_quote).to eq("\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi")
      expect(student.twitter).to eq("someone@twitter.com")
    end
  end

  describe '.all' do
    it 'returns the class variable @@all' do
      Student.class_variable_set(:@@all, [])
      expect(Student.all).to match_array([])
    end
  end

=end