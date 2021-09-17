### AES in ECB mode

# Belonging file: data/7.txt
file_path = File.join(__dir__, 'data', '7.txt')
file = File.open(file_path)
file_data = file.read

# Calculation
key = "YELLOW SUBMARINE"

require 'raw_string'

# Flag:
# "I'm back and I'm ringin' the bell [...]"

puts "Flag:"
puts file_data.b64_to_raw.decrypt_aes_ecb(key)
