
import SwiftUI

// View model.
//
// `ObservableObject` is the objects that can publish to the world "something
// changed".
class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static let emojis = [
        "⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱",
        "🪀", "🏓", "🏸", "🏒", "🏑", "🥍", "🏏", "🪃", "🥅", "⛳️",
    ]

    // `@Published` calls `objectWillChange.send()` (in `ObservableObject`)
    // every times the variable changed.
    @Published private var model = EmojiMemoryGame.createMemortGame()
    
    static func createMemortGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairOfCards: 8) {
            emojis[$0]
        }
    }
    
    var cards: [Card] {
        // We shouldn't expose the model to views
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        // Change the model. It is easy here because our model is just a struct
        // in memory. If our model is a database or network fetching, it could
        // be quite complicated.
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemortGame()
    }
}
