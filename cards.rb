# Globals, uh oh
$suits = ["hearts", "clubs", "diamonds", "spades"]

def result(hand, table)

    combined = hand + table

    combined = combined.sort.reverse 

    # Build a hash to count occurunces in a suit
    suit_count = {}
    $suits.each { |s| suit_count.merge!( { s => 0 } ) }

    pairs = {}

    visited = []
    combined.each do |card|

        # Add to flush check
        suit_count[card[0]] += 1

        # Check if value has been found before
        if visited.index { |c| c[1] == card[1] }

            # Add to the hash of pair counts
            if not pairs.key? card[1]
                pairs = pairs.merge!({ card[1] => 2 })
            else
                pairs[card[1]] += 1
            end
        end

        visited.push card
    end

    if pairs.count == 1
        "Pair of #{pairs.values.first}s"
    elsif pairs.count == 2
        if pairs.values.index { |v| v > 2 }
            "Full house: #{pairs.keys.join(" and ")}"
        else
            "Two Pair: #{pairs.keys.join(" and ")}"
        end
    else
        "#{combined.first[1]} high"
    end
end

# Main loop
10.times do |game|
    deck = $suits.product( 
        (2..13).to_a  )

    deck = deck.shuffle
    players = []
    4.times do
        # Take and drop
        hand = deck.take(2)
        deck = deck.drop(2)
        
        players.push(hand)
    end

    table = []
    table += deck.take(3)
    #puts "Flop: #{table}"
    deck = deck.drop(3)

    table += deck.take(1)
    deck.drop 1
    #puts "River: #{table.last}"

    table += deck.take 1
    deck.drop 1
    #puts "Street: #{table.last}"

    puts "Game #{game + 1}"

    count = 0
    players.each do |player|
        out = result player, table
        puts "Player #{count}: #{out}"
        count += 1
    end
end