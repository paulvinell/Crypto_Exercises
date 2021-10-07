### Implement PKCS#7 padding

require 'raw_string'

a = "YELLOW SUBMARINE"
b = a.to_raw.pad(20).value

puts "Before padding: #{a.inspect}"
puts "After padding: #{b.inspect}"
