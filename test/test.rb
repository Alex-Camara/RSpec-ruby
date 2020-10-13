require 'rspec/autorun'
require_relative '../lib/Hand'

describe Hand do 

    context "get consecutive cards" do
        
        it "gets two separate consecutive cards, same suit" do
            cards = %w(10H JH 6C 3H 4H)
            hand = Hand.new(cards)
            expect(hand.get_consecutive_and_not_consecutive_cards(true)).to eq({:consecutive_cards=>[["3H", "4H"],["10H", "JH"]], :non_consecutive_cards=>["6C"]})
        end

        it "gets two consecutive cards at the beginning, same suit" do
            cards = %w(AS 2S 6C JD 4H)
            hand = Hand.new(cards)
            expect(hand.get_consecutive_and_not_consecutive_cards(true)).to eq({:consecutive_cards=>[["AS", "2S"]], :non_consecutive_cards=>["4H", "6C", "JD"]})
        end

        it "gets two consecutive cards at the end, same suit" do
            cards = %w(KS 2S 6C JD QD)
            hand = Hand.new(cards)
            expect(hand.get_consecutive_and_not_consecutive_cards(true)).to eq({:consecutive_cards=>[["JD", "QD"]], :non_consecutive_cards=>["2S", "6C", "KS"]})
        end

        it "gets two consecutive cards at the center, same suit" do
            cards = %w(KS 2S 3S AD QD)
            hand = Hand.new(cards)
            expect(hand.get_consecutive_and_not_consecutive_cards(true)).to eq({:consecutive_cards=>[["2S", "3S"]], :non_consecutive_cards=>["AD", "QD", "KS"]})
        end

        it "gets two separate consecutive cards, different suit" do
            cards = %w(10H JC 6C 3H 4D)
            hand = Hand.new(cards)
            expect(hand.get_consecutive_and_not_consecutive_cards(false)).to eq({:consecutive_cards=>[["3H", "4D"],["10H", "JC"]], :non_consecutive_cards=>["6C"]})
        end

        it "gets two consecutive cards at the beginning, different suit" do
            cards = %w(AS 2C 6C JD 4H)
            hand = Hand.new(cards)
            expect(hand.get_consecutive_and_not_consecutive_cards(false)).to eq({:consecutive_cards=>[["AS", "2C"]], :non_consecutive_cards=>["4H", "6C", "JD"]})
        end

        it "gets two consecutive cards at the end, different suit" do
            cards = %w(8S 2S 6C JD QH)
            hand = Hand.new(cards)
            expect(hand.get_consecutive_and_not_consecutive_cards(false)).to eq({:consecutive_cards=>[["JD", "QH"]], :non_consecutive_cards=>["2S", "6C", "8S"]})
        end

        it "gets two consecutive cards at the center, different suit" do
            cards = %w(KS 2S 3H 5D JD)
            hand = Hand.new(cards)
            expect(hand.get_consecutive_and_not_consecutive_cards(false)).to eq({:consecutive_cards=>[["2S", "3H"]], :non_consecutive_cards=>["5D", "JD", "KS"]})
        end

        it "gets three consecutive cards at the beginning, same suit" do
            cards = %w(AS 2S 3S JD 4H)
            hand = Hand.new(cards)
            expect(hand.get_consecutive_and_not_consecutive_cards(true)).to eq({:consecutive_cards=>[["AS", "2S", "3S"]], :non_consecutive_cards=>["4H", "JD"]})
        end

        it "gets three consecutive cards at the end, same suit" do
            cards = %w(AD 6H 3C 4C 5C)
            hand = Hand.new(cards)
            expect(hand.get_consecutive_and_not_consecutive_cards(true)).to eq({:consecutive_cards=>[["3C", "4C", "5C"]], :non_consecutive_cards=>["AD", "6H"]})
        end

        it "gets three consecutive cards at the center, same suit" do
            cards = %w(AD 2C 3C 4C 9S)
            hand = Hand.new(cards)
            expect(hand.get_consecutive_and_not_consecutive_cards(true)).to eq({:consecutive_cards=>[["2C", "3C", "4C"]], :non_consecutive_cards=>["AD", "9S"]})
        end

        it "gets three consecutive cards at the beginning, different suit" do
            cards = %w(AS 2C 3H JD 6H)
            hand = Hand.new(cards)
            expect(hand.get_consecutive_and_not_consecutive_cards(false)).to eq({:consecutive_cards=>[["AS", "2C", "3H"]], :non_consecutive_cards=>["6H", "JD"]})
        end

        it "gets three consecutive cards at the end, different suit" do
            cards = %w(AD 9H 3C 4H 5S)
            hand = Hand.new(cards)
            expect(hand.get_consecutive_and_not_consecutive_cards(false)).to eq({:consecutive_cards=>[["3C", "4H", "5S"]], :non_consecutive_cards=>["AD", "9H"]})
        end

        it "gets three consecutive cards at the center, different suit" do
            cards = %w(KD 2H 3D 4C 9S)
            hand = Hand.new(cards)
            expect(hand.get_consecutive_and_not_consecutive_cards(false)).to eq({:consecutive_cards=>[["2H", "3D", "4C"]], :non_consecutive_cards=>["9S", "KD"]})
        end
    end

    context "get sets of cards with same number" do
        it "gets one pair" do
            cards = %w(5H 2H 10D 8D 2S)
            hand = Hand.new(cards)
            expect(hand.get_grouped_cards_by_same_number).to eq({:pairs=>[["2H", "2S"]], :non_pairs=>["5H", "8D", "10D"]})
        end

        it "gets two pairs" do
            cards = %w(AH 2H 10D AD 2S)
            hand = Hand.new(cards)
            expect(hand.get_grouped_cards_by_same_number).to eq({:pairs=>[["AD", "AH"], ["2S", "2H"]], :non_pairs=>["10D"]})
        end

        it "gets one pair and a three of a kind" do
            cards = %w(10S 10H KC KH KS)
            hand = Hand.new(cards)
            expect(hand.get_grouped_cards_by_same_number).to eq({:pairs=>[["10H", "10S"], ["KH", "KS", "KC"]], :non_pairs=>[]})
        end

        it "gets one three of a kind" do
            cards = %w(10S 10H KC 10D KS)
            hand = Hand.new(cards)
            expect(hand.get_grouped_cards_by_same_number).to eq({:pairs=>[["10H","10D", "10S"], ["KS", "KC"]], :non_pairs=>[]})
        end

        # it "gets groups with three and two" do
        #     cards = %w(10H 2H 10D 2D 2S)
        #     hand = Hand.new(cards)
        #     expect(hand.get_grouped_cards_by_same_number).to eq({:pairs=>[["2H", "2D", "2S"],["10D", "10H"]], :non_pairs=>[]})
        # end

        # it "gets groups with three and two in different order" do
        #     cards = %w(10H 2S 2D 5C 2J)
        #     hand = Hand.new(cards)
        #     expect(hand.get_grouped_cards_by_same_number).to eq({:pairs=>[["2S", "2D", "2J"]], :non_pairs=>["5C", "10H"]})
        # end

        # it "gets a pair and the rest are nonpairs" do
        #     cards = %w(10H 2S 2D 5C 8J)
        #     hand = Hand.new(cards)
        #     expect(hand.get_grouped_cards_by_same_number).to eq({:pairs=>[["2S", "2D"]], :non_pairs=>["5C", "8J", "10H"]})
        # end
    end
    
    context "checking straight flush" do
        it "gets a minimal straight flush" do
            cards = %w(2H AH 3H 4H 5H)
            hand = Hand.new(cards)
            expect(hand.get_straight(is_flush: true)).to eq(["AH", "2H", "3H", "4H", "5H"])
        end

        it "gets a maximal straight flush (royal flush)" do
            cards = %w(10S AS QS KS JS)
            hand = Hand.new(cards)
            expect(hand.get_straight(is_flush: true)).to eq(["10S", "JS", "QS", "KS", "AS"])
        end

        it "does not get a straight flush, the suit is not the same" do
            cards = %w(9S 10H JS QS KS)
            hand = Hand.new(cards)
            expect(hand.get_straight(is_flush: true)).to eq(nil)
        end

        it "does not get a straight flush, the order is not consecutive" do
            cards = %w(3S 5S 4S AS 6S)
            hand = Hand.new(cards)
            expect(hand.get_straight(is_flush: true)).to eq(nil)
        end
    end

    context "checking four of a kind" do
        it "gets four of a kind at the beginning, same suits" do
            cards = %w(2S 2S 2S 2S 10H)
            hand = Hand.new(cards)
            expect(hand.get_four_of_a_kind).to eq({:four=>["2S","2S","2S","2S"], :kicker=>"10H"})
        end

        it "gets four of a kind at the beginning, different suits" do
            cards = %w(6S 6H 6D 6C 10H)
            hand = Hand.new(cards)
            expect(hand.get_four_of_a_kind).to eq({:four=>["6H","6D","6C","6S"], :kicker=>"10H"})
        end

        it "gets four of a kind at the end, different suits" do
            cards = %w(10D 2H 2S 2S 2D)
            hand = Hand.new(cards)
            expect(hand.get_four_of_a_kind).to eq({:four=>["2H","2S","2S","2D"], :kicker=>"10D"})
        end

        it "does not get a four of a kind" do
            cards = %w(10D 2S 3S 6S 2S)
            hand = Hand.new(cards)
            expect(hand.get_four_of_a_kind).to eq(nil)
        end
    end

    context "checking full house" do
        it "gets full house with non matching suits" do
            cards = %w(10S 10H KC KH KS)
            hand = Hand.new(cards)
            expect(hand.get_full_house).to eq([["10H", "10S"], ["KH", "KS", "KC"]])
        end

        it "gets full house with one matching suit" do
            cards = %w(10S 10S KC KH KS)
            hand = Hand.new(cards)
            expect(hand.get_full_house).to eq([["10S", "10S"], ["KH", "KS", "KC"]])
        end

        it "gets full house with two matching suits" do
            cards = %w(10S 10S KH KH KH)
            hand = Hand.new(cards)
            expect(hand.get_full_house).to eq([["10S", "10S"], ["KH", "KH", "KH"]])
        end

        it "does not get full house" do
            cards = %w(10S JH KC KH KS)
            hand = Hand.new(cards)
            expect(hand.get_full_house).to eq(nil)
        end
    end

    context "checking flush" do
        it "gets a flush" do
            cards = %w(10S AS JS 4S KS)
            hand = Hand.new(cards)
            expect(hand.get_flush).to eq(["AS", "4S", "10S", "JS", "KS"])
        end

        it "does not get a flush" do
            cards = %w(10S AS JS 4H KS)
            hand = Hand.new(cards)
            expect(hand.get_flush).to eq(nil)
        end
    end

    context "checking straight" do
        it "gets a straight" do
            cards = %w(10C AD KC QH JS)
            hand = Hand.new(cards)
            expect(hand.get_straight(is_flush: false)).to eq(["10C", "JS", "QH", "KC", "AD"])
        end

        it "does not get a flush" do
            cards = %w(10S AS JS 4H KS)
            hand = Hand.new(cards)
            expect(hand.get_straight(is_flush: false)).to eq(nil)
        end
    end

    context "checking three of a kind" do
        it "gets three of a kind at the beginning" do
            cards = %w(10C 10C 10C QH JS)
            hand = Hand.new(cards)
            expect(hand.get_three_of_a_kind).to eq({:three=>["10C","10C","10C"], :rest=>["JS", "QH"]})
        end

        it "gets three of a kind at the end" do
            cards = %w(QH JS 10C 10C 10C)
            hand = Hand.new(cards)
            expect(hand.get_three_of_a_kind).to eq({:three=>["10C","10C","10C"], :rest=>["JS", "QH"]})
        end

        it "does not get a three of a kind" do
            cards = %w(10S 4S JS 4H KS)
            hand = Hand.new(cards)
            expect(hand.get_three_of_a_kind).to eq(nil)
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