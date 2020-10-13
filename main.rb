require_relative './lib/Hand'

# hand = Hand.new(%w(KH QH JH 10H AH))
hand = Hand.new(%w(10S 10H KC KH 3S))

puts hand.get_two_pairs.inspect