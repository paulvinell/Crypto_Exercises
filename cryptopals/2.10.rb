### Implement CBC mode

# Belonging file: data/10.txt
file_path = File.join(__dir__, 'data', '10.txt')
file = File.open(file_path)
file_data = file.read

# Calculation
key = "YELLOW SUBMARINE"
iv = [0]*16

require 'raw_string'

a = "I am testing out AES CBC encryption. I hope it works. Pad to 64."
b = a.to_raw.encrypt_aes_cbc(key, iv)
c = b.to_raw.decrypt_aes_cbc(key, iv)

raise "Encryption/decryption is broken. dec(enc(x)) != x." if a != c

file_data.b64_to_raw.decrypt_aes_cbc(key, iv) => flag

# Flag:
# "I'm back and I'm ringin' the bell [...]"

puts "Flag:"
puts flag
puts

flag.to_raw.encrypt_aes_cbc(key, iv).to_raw.to_b64 => enc

puts "Re-encrypted output matching input? #{enc == file_data ? "yes" : "no"}"
