//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Kk Shinkai on 2021/2/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            let game = EmojiMemoryGame()
            ContentView(viewModel: game)
        }
    }
}
