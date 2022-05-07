def input_students_and_cohorts
  # create an empty array
  students = []
  # output blank line
  puts ""
  while true
    puts "Please enter the names and cohorts of the students"
    puts "To finish, type stop"
    name = gets.chomp
    if name == "stop"
      break
    end
    unless name.empty?
      # Get the cohort next and use default if none given
      cohort = input_cohort
      # add the student hash to the array
      students << {name: name, cohort: cohort}
      puts ""
      puts "Now we have #{students.count} students"
      puts ""
    end    
  end
  # return the array of students
  students
end

def input_cohort
  # output blank line
  puts ""
  while true
    puts "Please input the month for cohort (default #{DEFAULT_COHORT})"
    cohort = gets.chomp
    if cohort.empty?
      return DEFAULT_COHORT
    else
      cohort = cohort.downcase 
      if valid_cohort(cohort)
        return cohort.intern
      end
    end
  end
end

def valid_cohort(cohort)
  COHORT_STRINGS.include?(cohort)
end

def print_padded_header
  # output blank line
  puts ""
  puts "The students of Villains Academy"
  puts "--------------------------------"
  print "Num".center(NUMBER_WIDTH)
  print "Name".center(NAME_WIDTH)
  puts "Cohort".center(COHORT_WIDTH)
end

def print_footer(students)
  # output blank line
  puts ""
  puts "Overall, we have #{students.count} great students"
end

def print_padded_students_initial_short_names(students, letter, length_less_than)
    i = 0
    while i < students.length
      if students[i][:name][0].casecmp?(letter) && students[i][:name].length < length_less_than 
        # puts "#{i+1}. #{students[i][:name]} (#{students[i][:cohort]} cohort)"
        print "#{i+1}".center(NUMBER_WIDTH)
        print "#{students[i][:name]}".center(NAME_WIDTH)
        puts "#{students[i][:cohort]}".center(COHORT_WIDTH)
      end
      i += 1
    end
end
  
def get_student_initial
  # output blank line
  puts ""
  while true
    puts "Please enter initial of students whose names you'd like to print"
    initial = gets.chomp
    unless initial.empty?
      initial = initial[0]
      break
    end
  end
  initial
end

# set some constants
NAME_LENGTH_LESS_THAN = 12
NUMBER_WIDTH = 6
NAME_WIDTH = 14
COHORT_WIDTH = 10
DEFAULT_COHORT = :november
COHORT_STRINGS = [ "january", "february", "march", "april",
                   "may", "june", "july", "august", "september",
                   "october", "november", "december" ]
# nothing happens until we call the methods
students = input_students_and_cohorts
initial = get_student_initial
print_padded_header
print_padded_students_initial_short_names(students, initial, NAME_LENGTH_LESS_THAN)
print_footer(students)
