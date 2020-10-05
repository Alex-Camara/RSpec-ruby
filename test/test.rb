require 'rspec/autorun'
require_relative '../lib/Hand'

describe Hand do 

    context "it's a straight flush" do
        
        it "gets straight flush" do
            cards = %w(10H 3S 6C KH QS)
            hand = Hand.new(cards)
            expect(hand.get_straight_flush).to eq("KH")
        end
    end
    
    # context "it's a tie" do
    #     it "gets highest card" do
    #         cards = %w(10H 3S 6C KH QS)
    #         hand = Hand.new(cards)
    #         expect(hand.get_highest_card).to eq("KH")
    #     end

    #     it "gets highest card when all cards are numbers" do
    #         cards = %w(10H 3S 6C 2H 5S)
    #         hand = Hand.new(cards)
    #         expect(hand.get_highest_card).to eq("10H")
    #     end

    #     it "gets highest card when most cards are letters" do
    #         cards = %w(QH KS JC 2H 5S)
    #         hand = Hand.new(cards)
    #         expect(hand.get_highest_card).to eq("KS")
    #     end
    # end

    # context "there's one pair" do
    #     it "gets one pair" do
    #         cards = %w(10H 3S 3S KH QS)
    #         hand = Hand.new(cards)
    #         expect(hand.get_pairs).to eq([["3S", "3S"]])
    #     end

    #     it "there is no pair" do
    #         cards = %w(10H 3C 3S KH QS)
    #         hand = Hand.new(cards)
    #         expect(hand.get_pairs).to eq([])
    #     end
    # end

    # context "there are two pairs" do
    #     it "gets two pairs" do
    #         cards = %w(10H 10H 3S 3S QS)
    #         hand = Hand.new(cards)
    #         expect(hand.get_pairs).to eq([["3S", "3S"],["10H", "10H"]])
    #     end

    #     it "there are not two pairs" do
    #         cards = %w(10H 10C 3S 7S QS)
    #         hand = Hand.new(cards)
    #         expect(hand.get_pairs).to eq([])
    #     end 
    # end
end