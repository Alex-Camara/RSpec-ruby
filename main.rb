require_relative './lib/Hand'

hand = Hand.new(%w(AS 2S 3S 4S 5S))

puts hand.get_straight_flush.inspect