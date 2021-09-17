### Detect AES in ECB mode

# Belonging file: data/8.txt
file_path = File.join(__dir__, 'data', '8.txt')
file = File.open(file_path)
file_data = file.read

# Calculation
ecb_index = -1

require 'raw_string'

file_data.split("\n").each_with_index do |line, index|
  if line.hex_to_raw.aes_ecb?
    ecb_index = index
    break
  end
end

# ECB at line index: 132
puts "ECB at line index: #{ecb_index}"
