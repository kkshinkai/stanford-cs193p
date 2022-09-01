import SwiftUI

@main
struct MemorizeApp: App {
    // View model
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
