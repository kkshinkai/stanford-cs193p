//
//  MemoryGame.swift
//  Memorize
//
//  Created by Kk Shinkai on 2021/2/21.
//

import Foundation

typealias Game = MemoryGame<String>

struct MemoryGame<CardContent> {
    var cards: [Card]
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }
    
    func choose(card: Card) {
        print("card chosen: \(card)")
    }
    
    struct Card: Identifiable {
        var content: CardContent
        var isFaceUp = true
        var isMatched = false
        var id: Int
    }
}
