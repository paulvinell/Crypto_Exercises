### Break repeating-key XOR

# Belonging file: data/6.txt
file_path = File.join(__dir__, 'data', '6.txt')
file = File.open(file_path)
file_data = file.read

require 'scoring'
require 'xor'

# Hamming distance test
hamming_dist_test_score = "this is a test".to_raw.hamming_dist("wokka wokka!!!".to_raw)
if hamming_dist_test_score != 37
  raise "Hamming distance test failed. Predicted: #{hamming_dist_test_score}. Actual: 37"
end

a = file_data.b64_to_raw
keysize = xor_keysize(a, [2, 40], samples: 10).first.first

# Keysize: 29
# Key: Terminator X: Bring the noise
#
# Flag:
# "I'm back and I'm ringin' the bell [...]"

puts "Keysize: #{keysize}"

key = xor_key_brute_daq(a, keysize) do |raw_string|
  char_freq(raw_string.value)
end

puts "Key: #{key.value}"
puts
puts "Flag:"
puts (a ^ key).value
