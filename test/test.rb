require 'rspec/autorun'
require_relative '../lib/Hand'

describe Hand do 

    context "get consecutive cards" do
        
        it "gets two separate consecutive cards" do
            cards = %w(10H JH 6C 3H 4H)
            hand = Hand.new(cards)
            expect(hand.get_consecutive_and_not_consecutive_cards).to eq({:consecutive_cards=>[["10H", "JH"], ["3H", "4H"]], :non_consecutive_cards=>["6C"]})
        end

        it "gets two consecutive cards at the beginning" do
            cards = %w(AS 2S 6C JD 4H)
            hand = Hand.new(cards)
            expect(hand.get_consecutive_and_not_consecutive_cards).to eq({:consecutive_cards=>[["AS", "2S"]], :non_consecutive_cards=>["6C", "JD", "4H"]})
        end

        it "gets two consecutive cards at the end" do
            cards = %w(KS 2S 6C JD QD)
            hand = Hand.new(cards)
            expect(hand.get_consecutive_and_not_consecutive_cards).to eq({:consecutive_cards=>[["JD", "QD"]], :non_consecutive_cards=>["KS", "2S", "6C"]})
        end

        it "gets two consecutive cards at the center" do
            cards = %w(KS 2S 3S AD QD)
            hand = Hand.new(cards)
            expect(hand.get_consecutive_and_not_consecutive_cards).to eq({:consecutive_cards=>[["2S", "3S"]], :non_consecutive_cards=>["KS", "AD", "QD"]})
        end

        it "gets three consecutive cards at the beginning" do
            cards = %w(AS 2S 3S JD 4H)
            hand = Hand.new(cards)
            expect(hand.get_consecutive_and_not_consecutive_cards).to eq({:consecutive_cards=>[["AS", "2S", "3S"]], :non_consecutive_cards=>["JD", "4H"]})
        end

        it "gets three consecutive cards at the end" do
            cards = %w(AD 6C 3C 4C 5C)
            hand = Hand.new(cards)
            expect(hand.get_consecutive_and_not_consecutive_cards).to eq({:consecutive_cards=>[["3C", "4C", "5C"]], :non_consecutive_cards=>["AD", "6C"]})
        end

        it "gets three consecutive cards at the center" do
            cards = %w(AD 2C 3C 4C 9S)
            hand = Hand.new(cards)
            expect(hand.get_consecutive_and_not_consecutive_cards).to eq({:consecutive_cards=>[["2C", "3C", "4C"]], :non_consecutive_cards=>["AD", "9S"]})
        end
    end
    
    context "checking straight flush" do
        it "gets a minimal straight flush" do
            cards = %w(AH 2H 3H 4H 5H)
            hand = Hand.new(cards)
            expect(hand.get_straight_flush).to eq(["AH", "2H", "3H", "4H", "5H"])
        end

        it "gets a maximal straight flush" do
            cards = %w(9S 10S JS QS KS)
            hand = Hand.new(cards)
            expect(hand.get_straight_flush).to eq(["9S", "10S", "JS", "QS", "KS"])
        end

        it "does not get a straight flush" do
            cards = %w(9S 10H JS QS KS)
            hand = Hand.new(cards)
            expect(hand.get_straight_flush).to eq(nil)
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