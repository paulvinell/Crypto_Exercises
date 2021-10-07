### An ECB/CBC detection oracle

require 'raw_string'

# Encrypts an input under a random AES mode, key, iv, and padding
# Input: string: plain text string
# Output: [string, symbol]: encrypted version of string and a
#                           symbol representing the AES mode (:AES/:ECB)
def encryption_oracle(input)
  pre_pad = Array.new(rand(5..10)) { |i| rand(0..255) }
  post_pad = Array.new(rand(5..10)) { |i| rand(0..255) }

  rand_key = Array.new(16) { |i| rand(0..255) }

  if [true, false].sample
    rand_iv = Array.new(16) { |i| rand(0..255) }

    [input.to_raw.encrypt_aes_cbc(rand_key, rand_iv), :CBC]
  else

    [input.to_raw.encrypt_aes_ecb(rand_key), :ECB]
  end
end

input = ["ORACLE INPUT"]*20
input = input.join(" ")

output, mode = encryption_oracle(input)

puts "Input:"
puts input
puts
puts "Predicted mode: #{output.to_raw.aes_ecb? ? "ECB" : "CBC"}"
puts "Actual mode: #{mode.to_s}"
