class Student

    attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

    @@all = []

    def initialize(student_hash)
        # Mass-assigns each key as an instance variable and each value as that variable's value.
        student_hash.each do |key,value|
            self.send(("#{key}="), value)
        end
        @@all << self
    end

    def self.create_from_collection(students_array)
        # Takes array of hashes and iterates over each hash.
        # Instantiates a new instance with the hash passed in as #initialize argument.
        students_array.each do |student|
            self.new(student)
        end
    end

    def add_student_attributes(attributes_hash)
        # binding.pry
        # Mass-assigns each key as an instance variable and each value as that variable's value.
        attributes_hash.each do |key,value|
            self.send(("#{key}="), value)
        end
    end

    def self.all
        @@all
    end

end

