
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  students.each_with_index do |student, index|
    puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

def print_students_with_initial(students, letter)
  students.each_with_index do |student, index|
    if student[:name][0].casecmp?(letter) 
      puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def get_student_initial
  while true
    puts "Please enter initial of students whose names you'd like to print"
    initial = gets.chomp[0]
    unless initial.empty?
      break
    end
  end
  initial
end

# nothing happens until we call the methods
students = input_students
print_header
initial = get_student_initial
# print(students)
print_students_with_initial(students, initial)
print_footer(students)
