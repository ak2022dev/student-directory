@students = [] # an empty array accessible to all methods

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
#    @students << {name: name, cohort: :november}
    add_student_and_cohort(name, DEFAULT_COHORT)
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_students_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" # 9 because we'll be adding more items
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      puts_padded_message("You have chosen the option to input students")
      input_students
      puts ""
    when "2"
      puts_padded_message("You have chosen the option to show students")
      show_students
      puts ""
    when "3"
      puts_padded_message("You have chosen the option to save the list of students")
      save_students
      puts_padded_message("The list of students has been saved to students.csv")
    when "4"
      puts_padded_message("You have chosen the option to load the list of students")
      load_students
      puts_padded_message("The list of students has been loaded from students.csv")
    when "9"
      puts_padded_message("You have chosen the option to exit")
      exit # this will cause the program to terminate
    else
      puts "I don't know what you mean, try again"
  end
end

def puts_padded_message( message )
  # prints message including vertical spacing before and after
  puts "\n\n#{message}"
  puts ""
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exist?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
#    @students << {name: name, cohort: cohort.to_sym}
    add_student_and_cohort(name, cohort.to_sym)
  end
  file.close
end

def add_student_and_cohort(name, cohort)
  # name is a string cohort is a symbol
  @students << {name: name, cohort: cohort}
end

DEFAULT_COHORT = :november

try_load_students
interactive_menu
