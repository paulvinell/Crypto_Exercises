### Single-byte XOR cipher

a = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"

require 'scoring'
require 'xor'

raw_a = a.hex_to_raw
key = xor_key_brute(raw_a) do |raw_string|
  char_freq(raw_string.value)
end

# Key: X
# Flag: Cooking MC's like a pound of bacon

puts "Key: #{key.value}"
puts
puts "Flag: #{(raw_a ^ key).value}"
