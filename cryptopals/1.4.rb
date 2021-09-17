### Detect single-character XOR

# Belonging file: data/4.txt
file_path = File.join(__dir__, 'data', '4.txt')
file = File.open(file_path)
file_data = file.read

require 'scoring'
require 'xor'

# Split lines by line break and reduce based on score.
# best: [line_index, score, raw_string, key]
line_index, score, best_line, key = file_data.split("\n").each_with_index.reduce(nil) do |best, current_line|
  line_index = current_line[1]
  raw_line = current_line[0].hex_to_raw
  key = xor_key_brute(raw_line) do |raw_string|
    char_freq(raw_string.value)
  end
  score = char_freq((raw_line ^ key).value)

  if best.nil? || best[1] < score
    [line_index, score, raw_line, key]
  else
    best
  end
end

# Line index: 170
# Key: 5
# Flag: Now that the party is jumping

puts "Line index: #{line_index}"
puts "Key: #{key.value}"
puts
puts "Flag: #{(best_line ^ key).value}"
