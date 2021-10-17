### PKCS#7 padding validation

require 'raw_string'

a = "ICE ICE BABY\x04\x04\x04\x04"
b = "ICE ICE BABY\x05\x05\x05\x05"
c = "ICE ICE BABY\x01\x02\x03\x04"

a_new = a.to_raw.unpad.value
b_new = b.to_raw.unpad.value
c_new = c.to_raw.unpad.value

a_sol = "ICE ICE BABY"
b_sol = "ICE ICE BABY\x05\x05\x05\x05"
c_sol = "ICE ICE BABY\x01\x02\x03\x04"

puts "A: #{a.inspect}"
puts "Unpadded: #{a_new.inspect}"
puts "Expected: #{a_sol.inspect}"
puts "Match: #{a_new == a_sol ? "yes" : "no"}"
puts

puts "B: #{b.inspect}"
puts "Unpadded: #{b_new.inspect}"
puts "Expected: #{b_sol.inspect}"
puts "Match: #{b_new == b_sol ? "yes" : "no"}"
puts

puts "C: #{c.inspect}"
puts "Unpadded: #{c_new.inspect}"
puts "Expected: #{c_sol.inspect}"
puts "Match: #{c_new == c_sol ? "yes" : "no"}"
