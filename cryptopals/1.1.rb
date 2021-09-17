### Convert hex to base64

# Hex string given in the exercise
a = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"

# Expected answer
b = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"

require 'raw_string'

# Intermediate/plain string: "I'm killing your brain like a poisonous mushroom"
puts "Flag: #{a.hex_to_raw.value}"
puts

answer = a.hex_to_raw.to_b64(strict: true)

puts "Input: #{a}"
puts "Expected output: #{b}"
puts "Actual output: #{answer}"
puts "Match: #{answer == b ? "yes" : "no"}"
