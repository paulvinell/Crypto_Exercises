### Byte-at-a-time ECB decryption (Simple)

require 'raw_string'

# Output: lambda: lambda that takes a string, appends the
#                 exercise secret and encrypts the string
#                 under a consistent 16-byte key.
def gen_encryption_oracle
  secret = <<-INPUT
  Um9sbGluJyBpbiBteSA1LjAKV2l0aCBteSByYWctdG9wIGRvd24gc28gbXkg
  aGFpciBjYW4gYmxvdwpUaGUgZ2lybGllcyBvbiBzdGFuZGJ5IHdhdmluZyBq
  dXN0IHRvIHNheSBoaQpEaWQgeW91IHN0b3A/IE5vLCBJIGp1c3QgZHJvdmUg
  YnkK
  INPUT
  secret = secret.gsub("\n", "").strip
  secret = secret.b64_to_raw(strict: false)

  rand_key = Array.new(16) { |i| rand(0..255) }

  -> (input) { (input + secret.value).to_raw.encrypt_aes_ecb(rand_key) }
end

oracle = gen_encryption_oracle

# Detected AES mode: ECB
# Detected blocksize: 16

blocksize = -1
(1..256).each do |length|
  input = "A"*length
  output = oracle.call(input)

  if output.to_raw.aes_ecb?

    blocksize = length / 2 # This works because there is no prefix added before our string

    puts "Detected AES mode: ECB"
    puts "Detected blocksize: #{blocksize}"

    break
  end
end

# Flag:
# Rollin' in my 5.

res = ""
(0..(blocksize - 1)).reverse_each do |length|
  base_str = ("A" * length)
  goal_output = oracle.call(base_str)

  (0..255).each do |brute_c|
    output = oracle.call(base_str + res + brute_c.chr)

    if goal_output[0, blocksize] == output[0, blocksize]
      res += brute_c.chr
      break
    end
  end
end

puts
puts "Flag:"
puts res
