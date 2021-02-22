//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Kk Shinkai on 2021/2/23.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: EmojiArtDoucment())
        }
    }
}
