require_relative './lib/Hand'

hand = Hand.new(%w(10S 10H KC KH KS))

puts hand.is_full_house?.inspect