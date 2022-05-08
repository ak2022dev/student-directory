require 'set'

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
  print "Name".center(NAME_WIDTH)
  puts "Cohort".center(COHORT_WIDTH)
end

def print_footer(students)
  # output blank line
  puts ""
  # correct singular/plural
  if students.count == 1
    puts "Overall, we have 1 great student"
  else
    puts "Overall, we have #{students.count} great students"
  end
end

def print_padded_students_grouped(students)
  # build a set of cohorts
  cohort_set = Set.new
  students.each do |hash_pair|
    cohort_set.add(hash_pair[:cohort])
  end
  cohort_set.each do |match|
    students.each do |hash_pair|
      if hash_pair[:cohort] == match
        print "#{hash_pair[:name]}".center(NAME_WIDTH)
        puts "#{hash_pair[:cohort]}".center(COHORT_WIDTH)
      end
    end
  end
end

# set some constants
NUMBER_WIDTH = 6
NAME_WIDTH = 27   # Assumption less than 25 in length
COHORT_WIDTH = 10
DEFAULT_COHORT = :november
COHORT_STRINGS = [ "january", "february", "march", "april",
                   "may", "june", "july", "august", "september",
                   "october", "november", "december" ]
# nothing happens until we call the methods
students = input_students_and_cohorts
puts students
print_padded_header
print_padded_students_grouped(students)
print_footer(students)
