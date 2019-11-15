require_relative "../lib/scraper.rb"
require_relative "../lib/student.rb"
require 'nokogiri'
require 'colorize'

class CommandLineInterface
  # constant set to the link used in this lab.
  BASE_PATH = "https://learn-co-curriculum.github.io/student-scraper-test-page/"

  # method used to initiate the CLI program.
  def run
    make_students
    add_attributes_to_students
    display_students
  end

  # creates a students_array using the Scraper class scrape_index_page method, then from the Student class creates new students using the create_from_collection method passing it the students_array.
  def make_students
    students_array = Scraper.scrape_index_page(BASE_PATH + 'index.html')
    Student.create_from_collection(students_array)
  end

  # iterates over each student created, sets an attributs variable to the students info using the Scraper class scrape_profile_page method, then using the Student class add_student_attributes method it passes in the attributes variable and adds those attributes to each student.
  def add_attributes_to_students
    Student.all.each do |student|
      attributes = Scraper.scrape_profile_page(BASE_PATH + student.profile_url)
      student.add_student_attributes(attributes)
    end
  end

  # using the Student class it iterates through each student and displays the students info.
  def display_students
    Student.all.each do |student|
      puts "#{student.name.upcase}".colorize(:blue)
      puts "  location:".colorize(:light_blue) + " #{student.location}"
      puts "  profile quote:".colorize(:light_blue) + " #{student.profile_quote}"
      puts "  bio:".colorize(:light_blue) + " #{student.bio}"
      puts "  twitter:".colorize(:light_blue) + " #{student.twitter}"
      puts "  linkedin:".colorize(:light_blue) + " #{student.linkedin}"
      puts "  github:".colorize(:light_blue) + " #{student.github}"
      puts "  blog:".colorize(:light_blue) + " #{student.blog}"
      puts "----------------------".colorize(:green)
    end
  end

end
