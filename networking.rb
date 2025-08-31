# Read an integer from standard input
number_of_users = gets.to_i
links = {}
users = {}

(0...number_of_users).each do |index|
  emails = gets.strip.split(" ")

  emails.each do |email1|
    emails.each do |email2|
      links[email1] ||= []
      links[email1] << email2
      links[email2] ||= []
      links[email2] << email1
    end

    users[email1] = 1
  end
end

groups_count = 0

while !users.empty?
  groups_count += 1

  to_check = [users.keys.first]

  # Find all the users that are connected to the one we have selected
  while !to_check.empty?
    user = to_check.pop

    next unless users.key?(user)

    users.delete(user)

    links[user].each do |linked_user|
      to_check << linked_user
    end
  end
end

puts groups_count
