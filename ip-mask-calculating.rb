# The script reads an IP address from standard input
ip = gets.chomp

# Match the IP address and subnet mask
matches = ip.match(/([0-9]+)\.([0-9]+)\.([0-9]+)\.([0-9]+)\/([0-9]+)/)

integers = matches[1..4].map(&:to_i) # The integers of the IP
mask = '1' * matches[5].to_i + '0' * (32 - matches[5].to_i) # The binary representation of the mask

# The network address
network = []
mask.split('').each_slice(8).with_index do |binary, index|
  network[index] = integers[index] & binary.join.to_i(2)
end

# The broadcast address
broadcast = []
mask.tr!("01", "10")
mask.split('').each_slice(8).with_index do |binary, index|
  broadcast[index] = network[index] | binary.join.to_i(2)
end

puts network.join(".")
puts broadcast.join(".")