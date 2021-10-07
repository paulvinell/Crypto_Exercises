### ECB cut-and-paste

# Support functions start here

require 'raw_string'

# Input: string: k=v string, e.g. "foo=bar&baz=qux&zap=zazzle"
# Output: hash: object representation
def decode_kv(str)
  str.split("&").to_h do |key_value_str|
    fragments = key_value_str.split("=")
    key = fragments[0]
    value = fragments[1..-1].join

    value = value.to_i if /\d+/.match?(value)

    [key, value]
  end
end

def encode_kv(obj)
  obj.map { |key, value| "#{key.to_s}=#{value}" }.join("&")
end

def profile_for(email)
  clean_email = email.gsub(/[&=]/, "")

  encode_kv({ email: clean_email, uid: 10, role: 'user' })
end

# Output: [lambda, lambda]: encryption and decryption oracle, respectively.
#                           Takes a single string as input.
def gen_oracle
  rand_key = Array.new(16) { |i| rand(0..255) }

  enc = -> (input) { profile_for(input).to_raw.encrypt_aes_ecb(rand_key) }
  dec = -> (input) { decode_kv(input.to_raw.decrypt_aes_ecb(rand_key)) }

  [enc, dec]
end

enc, dec = gen_oracle

# Calculations start here

blocksize = -1
(1..1024).each do |length|
  input = "A"*length
  output = enc.call(input)

  if output.to_raw.aes_ecb?(duplicate_count: 16)
    # We need a lot of samples because our input string does not start at a multiple of blocksize.
    # If our string, for instance, starts at index 3, and the blocksize is 16, then
    # we will need 7 + 16 + 16 characters before we even have a chance of detecting a repeat.
    blocksize = length / 16

    puts "Detected AES mode: ECB"
    puts "Detected blocksize: #{blocksize}"

    break
  end
end

ideal = "email=paulv@abc.xyz&uid=10&role=admin"
# 32 bytes => "email=paulv@abc.xyz&uid=10&role="

a = enc.call("paulv@abc.xyz")[0, 32]
# This gives us the base, enc("email=paulv@abc.xyz&uid=10&role=")

# "email=" => 6 bytes => we need 10 junk bytes
# "admin" => 5 bytes => we need to pad this out to 16 with a character that will be removed

b = (0.chr*10)
b += "admin"
b += (0.chr*11)
b = enc.call(b)[16, 16]

c = a + b

puts dec.call(c)
