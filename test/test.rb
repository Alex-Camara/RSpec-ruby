require 'rspec/autorun'
require_relative '../lib/Hand'

describe Hand do 

    context "it's a straight flush" do
        
        it "gets two separate consecutive cards" do
            cards = %w(10H JH 6C 3H 4H)
            hand = Hand.new(cards)
            expect(hand.get_number_of_consecutive_card).to eq([["10H", "JH"], ["3H", "4H"]])
        end

        it "gets two consecutive cards at the beginning" do
            cards = %w(AS 2S 6C JD 4H)
            hand = Hand.new(cards)
            expect(hand.get_number_of_consecutive_card).to eq([["AS", "2S"]])
        end

        it "gets two consecutive cards at the end" do
            cards = %w(KS 2S 6C JD QD)
            hand = Hand.new(cards)
            expect(hand.get_number_of_consecutive_card).to eq([["JD", "QD"]])
        end

        it "gets two consecutive cards at the center" do
            cards = %w(KS 2S 3S AD QD)
            hand = Hand.new(cards)
            expect(hand.get_number_of_consecutive_card).to eq([["2S", "3S"]])
        end

        it "gets three consecutive cards at the beginning" do
            cards = %w(AS 2S 3S JD 4H)
            hand = Hand.new(cards)
            expect(hand.get_number_of_consecutive_card).to eq([["AS", "2S", "3S"]])
        end

        it "gets three consecutive cards at the end" do
            cards = %w(AD 6C 3C 4C 5C)
            hand = Hand.new(cards)
            expect(hand.get_number_of_consecutive_card).to eq([["3C", "4C", "5C"]])
        end

        it "gets three consecutive cards at the center" do
            cards = %w(AD 2C 3C 4C 9S)
            hand = Hand.new(cards)
            expect(hand.get_number_of_consecutive_card).to eq([["2C", "3C", "4C"]])
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