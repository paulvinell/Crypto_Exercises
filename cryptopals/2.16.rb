### CBC bitflipping attacks

require 'raw_string'

str1 = "comment1=cooking%20MCs;userdata="
str2 = ";comment2=%20like%20a%20pound%20of%20bacon"

def gen_oracle(str1, str2)
  rand_key = Array.new(16) { |i| rand(0..255) }
  iv = [0]*16

  enc = -> (input) do
    str_clean = input.gsub(";", "X").gsub("=", "Y")

    (str1 + str_clean + str2).to_raw.encrypt_aes_cbc(rand_key, iv)
  end

  dec = -> (input) do
    decrypted = input.to_raw.
                      decrypt_aes_cbc(rand_key, iv).
                      to_raw.
                      unpad(raise_on_err: true).
                      value.
                      split(";").
                      include?("admin=true")
  end

  [enc, dec]
end

enc, dec = gen_oracle(str1, str2)

a = enc.call(";admin=true")

# "comment1=cooking%20MCs;userdata=" = 32 bytes

expected_plaintext = "comment1=cooking%20MCs;userdata=XadminYtrue;comment2=%20like%20a%20pound%20of%20bacon"

expected_block = "XadminYtrue;comm".to_raw
wanted_block = ";admin=true;comm".to_raw
xor_block = expected_block ^ wanted_block

a[16, 16] = (a[16, 16].to_raw ^ xor_block).value

puts "Admin: #{dec.call(a)}"
