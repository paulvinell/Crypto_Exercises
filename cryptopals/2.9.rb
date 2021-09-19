### Implement PKCS#7 padding

require 'block'

a = "YELLOW SUBMARINE"
b = pad(a.bytes, 20).pack("c*")

puts "Before padding: #{a.inspect}"
puts "After padding: #{b.inspect}"
