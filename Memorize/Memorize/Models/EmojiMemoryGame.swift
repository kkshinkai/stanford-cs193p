//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Kk Shinkai on 2021/2/21.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    static private let emojis = ["🍎", "🍊", "🍌", "🍉", "🍇", "🍓"]
    
    @Published private var model = createMemoryGame()
    
    private static func createMemoryGame() -> Game {
        Game(numberOfPairsOfCards: emojis.count) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }

    // MARK: - Access to the model
    
    var cards: [Game.Card] { model.cards }
    
    // MARK: - Intent(s)
    
    func choose(card: Game.Card) {
        objectWillChange.send()
        model.choose(card: card)
    }
}
