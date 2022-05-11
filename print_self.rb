# print_self.rb
# this file opens itself and prints itself

File.open($0, "r") do |f|
  f.readlines.each do |line|
    puts line
  end    
end
