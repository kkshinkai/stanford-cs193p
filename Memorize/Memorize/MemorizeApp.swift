import SwiftUI

@main
struct MemorizeApp: App {
    // View model
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
