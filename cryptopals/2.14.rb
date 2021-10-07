### Byte-at-a-time ECB decryption (Harder)

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

  prefix = Array.new(rand(1..32)) { |i| rand(0..255) }
  prefix = RawString.new(prefix)

  rand_key = Array.new(16) { |i| rand(0..255) }

  -> (input) { (prefix.value + input + secret.value).to_raw.encrypt_aes_ecb(rand_key) }
end

oracle = gen_encryption_oracle

# Detected AES mode: ECB
# Detected blocksize: 16
# Detected input string offset: variable

duplicate_index = -1
blocksize = -1
input_string_block_offset = -1
input_string_total_offset = -1
(1..1024).each do |length|
  input = "A"*length
  output = oracle.call(input)

  duplicate_index = output.to_raw.duplicate_index(16, duplicate_count: 16)

  if duplicate_index != -1
    blocksize = length / 16
    input_string_block_offset = blocksize - (length % blocksize)
    input_string_total_offset = (duplicate_index-1)*16 + input_string_block_offset

    puts "Detected AES mode: ECB"
    puts "Detected blocksize: #{blocksize}"
    puts "Detected input string block offset: #{input_string_block_offset}"
    puts "Detected input string total offset: #{input_string_total_offset}"

    break
  end
end

# Flag:
# "Rollin' in my 5.0
# With my rag-top down so my hair can blow
# The girlies on standby waving just to say hi
# Did you stop? No, I just drove by"

block_count = ((oracle.call('').length - input_string_total_offset) / blocksize.to_f).ceil.to_i
puts "Detected block count: #{block_count}"

res = "A"*(blocksize - 1)
block_count.times do |block_focus|
  (0..(blocksize - 1)).reverse_each do |length|
    base_str_pad = "A" * (blocksize - input_string_block_offset)
    base_str =  base_str_pad + "A"*length
    goal_output = oracle.call(base_str)

    found_match = false
    (0..255).each do |brute_c|
      output = oracle.call(base_str_pad + res[-(blocksize - 1)..] + brute_c.chr)

      if output[blocksize * duplicate_index, blocksize] == goal_output[blocksize * (duplicate_index + block_focus), blocksize]
        res += brute_c.chr
        found_match = true
        break
      end
    end

    break unless found_match
  end
end

res = res[15..]

puts
puts "Flag:"
puts res
