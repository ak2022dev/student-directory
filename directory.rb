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
  puts "3. Save the student list"
  puts "4. Load the student list"
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
      choose_file_save_students
      puts_padded_message("The list of students has been saved")
    when "4"
      puts_padded_message("You have chosen the option to load the list of students")
      choose_file_load_students
      puts_padded_message("The list of students has been loaded")
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

def choose_file_save_students
  # allow user to choose filename
  filename = get_filename
  # save student details
  save_students(filename)
end

def save_students(filename)
  # open the file for writing
  file = File.open(filename, "w") # at some stage process error here?
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def try_initial_load
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  load_students(filename)
  puts "Loaded #{@students.count} from #{filename}"
end

def choose_file_load_students
  # allow user to choose filename
  filename = get_filename
  # load from file
  load_students(filename)
end

def load_students(filename)
  # need to deal with nil filename
  # exit if file doesn't exist
  check_file_exists(filename)
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    add_student_and_cohort(name, cohort.to_sym)
  end
  file.close
end

def add_student_and_cohort(name, cohort)
  # name is a string cohort is a symbol
  @students << {name: name, cohort: cohort}
end

def get_filename
  puts ""
  print "Enter the name of the file (default students.csv if none given): "
  filename = STDIN.gets.chomp
  if filename.empty? 
    filename = DEFAULT_FILENAME
  end
  return filename
end

def check_file_exists(filename)
  # check file exists and exit if not
  if File.exist?(filename)
    return true
  else 
    # exit from unrecoverable error?
    puts "File #{filename} doesn't exist. Exiting program."
    exit
  end
end  

DEFAULT_COHORT = :november
DEFAULT_FILENAME = "students.csv"
try_initial_load
interactive_menu
