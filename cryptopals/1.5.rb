### Implement repeating-key XOR

# There is a space after the word "nimble"
# and if it's not there it won't work.
a = <<-LYRICS
Burning 'em, if you ain't quick and nimble
I go crazy when I hear a cymbal
LYRICS
a = a.strip

b = <<-RESULT
0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272
a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f
RESULT
b = b.gsub("\n", "").strip

require 'raw_string'

hex = (a.to_raw ^ "ICE".to_raw).to_hex

puts "Hex encoding:"
puts hex
puts "Hex encoding:"
puts b
puts
puts "Match: #{b == hex ? "yes" : "no"}"
