require_relative './lib/Hand'

hand = Hand.new(%w(10H 10H 3S 3C QS))

puts hand.get_pairs.inspect