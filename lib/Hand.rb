class Hand
    attr_accessor :cards

    def initialize(cards)
        @cards = cards
    end

    def get_straight_flush
        consecutive_cards = get_number_of_consecutive_card
        return consecutive_cards[0] unless consecutive_cards[0].length < 5
    end

    # @return gets an array of arrays containing al the groups of cards being consecutive
    def get_number_of_consecutive_card
        total_contiguous_cards = Array.new
        contiguous_cards = Array.new
        
        @cards.each_with_index do |card, index|

            # if the array is empty, it's the first round, we add the card
            if contiguous_cards.empty? 
                contiguous_cards.push(card)

            # if the corresponding index in the current card minus the index currently last in the 
            # contiguous_cards array equals -1, they are consecutive and thus, added to the contiguous_cards
            # array
            elsif are_cards_consecutive?(contiguous_cards.last, card)
                if index == @cards.length - 1
                    contiguous_cards.push(card)
                    total_contiguous_cards.push(contiguous_cards)
                elsif
                    contiguous_cards.push(card)
                end
                
            # if the contiguous_cards array has more than one card and the current card is not consecutive
            # then we add the contiguous_cards to the total_contiguous_cards and clear the 
            # contiguous_cards array. Finally we add the current card to the contiguous_cards array
            elsif contiguous_cards.length > 1 
                total_contiguous_cards.push(contiguous_cards)
                contiguous_cards = []
                contiguous_cards.push(card)
            else
                contiguous_cards = []
                contiguous_cards.push(card)
            end 
        end

        return total_contiguous_cards
    end

    # @param previous_card the card to compare to
    # @param current_card the card being compared
    # @return whether or not the current card value follows the previous card
    def are_cards_consecutive?(previous_card, current_card)
        previous_card_index = get_ordered_cards_index(previous_card)
        current_card_index = get_ordered_cards_index(current_card)

        have_same_index = (previous_card_index - current_card_index) == -1
        have_same_suit = current_card[-1] == previous_card[-1]

        return have_same_index & have_same_suit
    end

    def get_ordered_cards_index(card)
        ordered_cards = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
        correponding_index = ordered_cards.find_index { |ordered_card| ordered_card == card[0...-1]}
    end

    def get_pairs
        sorted_cards = sort_cards
        pairs = Array.new

        sorted_cards.each do |card|
            found_cards = sorted_cards.select { |aux_card| aux_card[0...-1] == card[0...-1]}
            has_been_already_found = pairs.find { |aux_card| aux_card[0] == card[0...-1]}
            if found_cards.length > 1 && !has_been_already_found
                pairs.push(found_cards)
            end
        end
        return pairs
    end

    def get_highest_card
        sorted_cards = sort_cards

        highest_card = sort_cards.last
        return highest_card
    end

    def sort_cards
        sorted_cards = Array.new
        letters_in_cards = ["J", "Q", "K", "A"]

        counter = 2

        until counter == 11 do
            found_cards = @cards.select { |card| card[0...-1] == counter.to_s}
            if found_cards.length > 0
                sorted_cards.push(*found_cards)
            end
            counter += 1
        end

        counter = 0

        until counter == letters_in_cards.length do
            found_cards = @cards.select { |card| card[0...-1] == letters_in_cards[counter]}
            if found_cards.length > 0
                sorted_cards.push(*found_cards)
            end
            counter += 1
        end

        return sorted_cards
    end
end