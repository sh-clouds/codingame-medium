# Read the number of people and links from standard input
people = gets.to_i
links = gets.to_i

groups = (0...people).to_a
clusters = Array.new(people) { |i| { i => 1 } }

links.times do
  a, b = gets.chomp.split.map(&:to_i)

  # People in the link are currently in different clusters
  if groups[a] != groups[b]
    cluster = clusters[groups[b]]
    clusters[groups[b]] = nil

    # Update all the people in the group we remove
    cluster.each_key do |index|
      groups[index] = groups[a]
    end

    # Merge the clusters
    clusters[groups[a]].merge!(cluster) if clusters[groups[a]]
  end
end

# Get the number of people in each cluster and group them
sizes = clusters.compact.group_by(&:size).transform_values(&:count)
sizes = sizes.sort.reverse.to_h

sizes.each do |size, frequency|
  puts "#{size} #{frequency}"
end