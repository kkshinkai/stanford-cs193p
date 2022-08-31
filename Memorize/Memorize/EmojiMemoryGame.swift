
import SwiftUI

class EmojiMemoryGame {
    static let emojis = [
        "⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱",
        "🪀", "🏓", "🏸", "🏒", "🏑", "🥍", "🏏", "🪃", "🥅", "⛳️",
    ]

    private var model = MemoryGame<String>(numberOfPairOfCards: 4) { emojis[$0] }
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
}
