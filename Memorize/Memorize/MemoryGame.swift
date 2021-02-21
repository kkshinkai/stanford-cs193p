//
//  MemoryGame.swift
//  Memorize
//
//  Created by Kk Shinkai on 2021/2/21.
//

import Foundation

typealias Game = MemoryGame<String>

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: [Card]
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            // TODO: I don't like the array here.
            cards.indices.filter{ cards[$0].isFaceUp }.only
        }
        set {
            cards.indices.forEach { index in
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }
    
    mutating func choose(card: Card) {
        // TODO: Need some optimizations here.
        let chosenIndex = cards.firstIndex{ $0.id == card.id }!
        if !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                // TODO: We should use id, not content. The content does not have to be Equable.
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp = true
        }
    }
    
    struct Card: Identifiable {
        var content: CardContent
        var isFaceUp = false
        var isMatched = false
        var id: Int
    }
}
