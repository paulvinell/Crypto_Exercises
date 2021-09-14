### Fixed XOR

# Given in exercise
a = "1c0111001f010100061a024b53535009181c"
b = "686974207468652062756c6c277320657965"

# Should when XOR:ed together match
c = "746865206b696420646f6e277420706c6179"

require 'raw_string'

a.hex_to_raw ^ b.hex_to_raw => d

# Bytes to chars gives:
# "the kid don't play"
puts "Flag: #{d.value}"
puts

d_hex = d.to_hex

puts "Input 1: #{a}"
puts "Input 2: #{b}"
puts "Expected output: #{c}"
puts "Actual output: #{d_hex}"
puts "Match: #{c == d_hex ? "yes" : "no"}"
