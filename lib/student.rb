class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    @name = name
  
    newstudent = student_hash.collect do |k, v|  instance_variable_set("@#{k}", v) unless v.nil?
    #student_hash.collect do |k, v| send(":k" => v)
    #send(newstudent, @@all)
     
                                      end
    # send(:newstudent, @@all)
    
  
  end


  def self.create_from_collection(students_array)
    
  end

  def add_student_attributes(attributes_hash)
    
  end

  def self.all
   @@all
  end
end

