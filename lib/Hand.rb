class Hand
    attr_accessor :cards

    def initialize(cards)
        @cards = cards
    end

    def get_straight_flush
        sorted_cards = sort_cards
    end

    def get_number_of_contiguous_card(cards)

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