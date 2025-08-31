# Get voters and number of votes allowed.
number_of_voters = gets.to_i
number_of_votes = gets.to_i
voters = {}
(0...number_of_voters).each do |i|
  inputs = gets.split
  person_name = inputs[0]
  number_of_votes_allowed = inputs[1].to_i
  voters[person_name] = number_of_votes_allowed
end

# Keep store of votes, names, vote results and any invalid names.
vote_counts = [0, 0]
voter_names = []
vote_results = []
invalid_voters = []
(0...number_of_votes).each do |i|
  voter_name, vote_value = gets.split
  voter_names << voter_name
  vote_results << vote_value
  if voter_names.count(voter_name) > voters.fetch(voter_name, Float::INFINITY)
    invalid_voters << voter_name
  end
end

# Add results only if valid voter.
voter_names.zip(vote_results).each do |name, vote_value|
  if !invalid_voters.include?(name) && voters.fetch(name, -1) > 0 && ["Yes", "No"].include?(vote_value)
    voters[name] -= 1
    vote_counts[vote_value == "No" ? 1 : 0] += 1
  end
end

# Print Yes and No totals.
puts vote_counts.join(" ")