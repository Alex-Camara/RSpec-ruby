class Hand
    attr_accessor :cards

    def initialize(cards)
        @cards = cards
    end

    # Determines if the cards provide a straight flush.
    # @return array with the straight flush. In case there's not a straigh flush, returns nil.
    def get_straight(is_flush:)
        consecutive_and_not_consecutive_cards = get_consecutive_and_not_consecutive_cards(is_flush)
        consecutive_cards = consecutive_and_not_consecutive_cards[:consecutive_cards][0]
        non_consecutive_cards = consecutive_and_not_consecutive_cards[:non_consecutive_cards][0]

        if consecutive_cards.length == 5
            return consecutive_cards
        # Validation in case there is a royal flush
        elsif consecutive_cards.length == 4 && consecutive_cards.last[0...-1] == "K" && non_consecutive_cards.include?("A")
            return consecutive_cards.push(non_consecutive_cards)
        end 
    end

    def get_four_of_a_kind
        cards_deck = get_grouped_cards_by_same_number
        new_cards_deck = {}

        if cards_deck[:pairs][0].length == 4
            new_cards_deck[:four] = cards_deck[:pairs][0]
            new_cards_deck[:kicker] = cards_deck[:non_pairs][0]
            return new_cards_deck
        else
            return nil
        end
    end

    def get_full_house
        cards_deck = get_grouped_cards_by_same_number
        
        if cards_deck[:pairs].length == 2
            return cards_deck[:pairs]
        else 
            return nil
        end
    end

    def get_flush
        sorted_cards = sort_cards
        first_suit = sorted_cards[0][-1]

        sorted_cards.each do |card| 
            next unless card[-1] != first_suit
            return nil
        end
        return sorted_cards
    end

    def get_three_of_a_kind
        cards_deck = get_grouped_cards_by_same_number
        new_cards_deck = {}

        puts cards_deck.inspect

        if cards_deck[:pairs][0].length == 3
            new_cards_deck[:three] = cards_deck[:pairs][0]
            new_cards_deck[:rest] = cards_deck[:non_pairs]
            return new_cards_deck
        else
            return nil
        end
    end

    def get_two_pairs
        cards_deck = get_grouped_cards_by_same_number
        new_cards_deck = {}

        puts cards_deck.inspect
        puts cards_deck[:pairs][0].inspect
        puts cards_deck[:pairs][0][1].length.inspect

        if cards_deck[:pairs].length == 2
            if cards_deck[:pairs][0].length == 2 && cards_deck[:pairs][1].length == 2
                new_cards_deck[:pairs] = cards_deck[:pairs]
                new_cards_deck[:rest] = cards_deck[:non_pairs]
                return new_cards_deck
            end
        else
            return nil
        end
    end

    # @return gets an array of arrays containing al the groups of cards being consecutive
    def get_consecutive_and_not_consecutive_cards(is_suit_relevant)
        total_consecutive_cards = Array.new
        consecutive_cards = Array.new
        non_consecutive_cards = Array.new
        sorted_cards = sort_cards
        
        sorted_cards.each_with_index do |card, index|

            # if the array is empty, it's the first round, we add the card
            if consecutive_cards.empty? 
                consecutive_cards.push(card)

            # if the corresponding index in the current card minus the index currently last in the 
            # consecutive_cards array equals -1, they are consecutive and thus, added to the consecutive_cards
            # array
            elsif are_cards_consecutive?(consecutive_cards.last, card, is_suit_relevant)
                if index == @cards.length - 1
                    consecutive_cards.push(card)
                    total_consecutive_cards.push(consecutive_cards)
                elsif
                    consecutive_cards.push(card)
                end
                
            # if the consecutive_cards array has more than one card and the current card is not consecutive
            # then we add the consecutive_cards to the total_consecutive_cards and clear the 
            # consecutive_cards array. Finally we add the current card to the consecutive_cards array
            elsif consecutive_cards.length > 1 
                total_consecutive_cards.push(consecutive_cards)
                consecutive_cards = []
                consecutive_cards.push(card)
                non_consecutive_cards.push(*consecutive_cards) unless index < @cards.length - 1
            else
                non_consecutive_cards.push(*consecutive_cards)
                consecutive_cards = []
                consecutive_cards.push(card)
                non_consecutive_cards.push(*consecutive_cards) unless index < @cards.length - 1
            end 
        end

        cards_deck = {:consecutive_cards => total_consecutive_cards, :non_consecutive_cards => non_consecutive_cards}

        return cards_deck
    end

    # @param previous_card the card to compare to
    # @param current_card the card being compared
    # @return whether or not the current card value follows the previous card
    def are_cards_consecutive?(previous_card, current_card, is_suit_relevant)
        have_same_suit = true
        previous_card_index = get_ordered_cards_index(previous_card)
        current_card_index = get_ordered_cards_index(current_card)

        have_same_index = (previous_card_index - current_card_index) == -1
        have_same_suit = current_card[-1] == previous_card[-1] unless !is_suit_relevant

        return have_same_index & have_same_suit
    end

    def get_ordered_cards_index(card)
        ordered_cards = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
        correponding_index = ordered_cards.find_index { |ordered_card| ordered_card == card[0...-1]}
    end

    def do_cards_have_the_same_number?(previous_card, current_card)
        previous_card_index = get_ordered_cards_index(previous_card)
        current_card_index = get_ordered_cards_index(current_card)

        return (have_same_index = previous_card_index == current_card_index)
    end

    def get_grouped_cards_by_same_number
        cards_deck = Hash.new
        pairs = Array.new
        non_pairs = Array.new
        current_pair = Array.new
        sorted_cards = sort_cards

        puts sorted_cards.inspect

        sorted_cards.each_with_index do |card, index|

            if index == 0
                current_pair.push(card)
            elsif do_cards_have_the_same_number?(current_pair[0], card)
                if index < (sorted_cards.length - 1)
                    current_pair.push(card)
                else
                    current_pair.push(card)
                    pairs.push(current_pair)
                end
            elsif current_pair.length > 1
                pairs.push(current_pair)
                if index < (sorted_cards.length - 1)
                    current_pair = []
                    current_pair.push(card)
                else
                    non_pairs.push(card)
                end
            elsif index < (sorted_cards.length - 1)
                non_pairs.push(*current_pair)
                current_pair = []
                current_pair.push(card)
            elsif index == (sorted_cards.length - 1)
                non_pairs.push(*current_pair)
                non_pairs.push(card)
            else
                non_pairs.push(*current_pair)
                current_pair = []
                current_pair.push(card)
            end
        end

        # In case the for loop didn't have a chance to get the current pair in the pairs array
        # if current_pair.length > 1
        #     pairs.push(current_pair)
        # end

        cards_deck = {:pairs => pairs, :non_pairs => non_pairs}
        return cards_deck
    end

    # def get_pairs
    #     sorted_cards = sort_cards
    #     pairs = Array.new

    #     sorted_cards.each do |card|
    #         found_cards = sorted_cards.select { |aux_card| aux_card[0...-1] == card[0...-1]}
    #         has_been_already_found = pairs.find { |aux_card| aux_card[0] == card[0...-1]}
    #         if found_cards.length > 1 && !has_been_already_found
    #             pairs.push(found_cards)
    #         end
    #     end
    #     return pairs
    # end

    # def get_highest_card
    #     sorted_cards = sort_cards

    #     highest_card = sort_cards.last
    #     return highest_card
    # end

    def sort_cards
        cards_deck =  []
        cards_with_index_array = []
    
        @cards.each do |card| 
            card_array = []
            card_index = get_ordered_cards_index(card)
            card_array << card << card_index
            cards_with_index_array << card_array
        end

        cards_with_index_array.sort_by! { |card| card[1]}

        cards_with_index_array.each do |card|
            cards_deck << card[0]
        end

        return cards_deck
    end
end