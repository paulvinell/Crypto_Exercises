### An ECB/CBC detection oracle

require 'raw_string'

# Encrypts an input under a random AES mode, key, iv, and padding
# Input: string: plain text string
# Output: string: encrypted version of string
def encryption_oracle(input)
  pre_pad = Array.new(rand(5..10)) { |i| rand(0..255) }
  post_pad = Array.new(rand(5..10)) { |i| rand(0..255) }

  rand_key = Array.new(16) { |i| rand(0..255) }

  if [true, false].sample
    rand_iv = Array.new(16) { |i| rand(0..255) }

    input.to_raw.encrypt_aes_cbc(rand_key, rand_iv)
  else

    input.to_raw.encrypt_aes_ecb(rand_key)
  end
end
