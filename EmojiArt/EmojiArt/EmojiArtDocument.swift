//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Kk Shinkai on 2021/2/23.
//

import SwiftUI

class EmojiArtDoucment: ObservableObject {
    static let palette = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍉",
                          "🍇", "🍓", "🫐", "🍈", "🍒", "🍑"]
    
    static let untitled = "EmojiArtDocument.Untitled"
    
    @Published
    private var emojiArt: EmojiArt {
        didSet {
            UserDefaults.standard.set(emojiArt.json,
                                      forKey: EmojiArtDoucment.untitled)
        }
    }
    
    init() {
        emojiArt = EmojiArt(json: UserDefaults.standard.data(forKey: EmojiArtDoucment.untitled)) ?? EmojiArt()
        fetchBackgroundImageData()
    }
    
    @Published
    private(set) var backgroundImage: UIImage?
    
    var emojis: [EmojiArt.Emoji] { emojiArt.emojis }
    
    func addEmoji(_ emoji: String, at location: CGPoint, size: CGFloat) {
        emojiArt.addEmoji(emoji, x: Int(location.x), y: Int(location.y),
                          size: Int(size))
    }
    
    func moveEmoji(_ emoji: EmojiArt.Emoji, by offset: CGSize) {
        let index = emojiArt.emojis.firstIndex{ $0.id == emoji.id }!
        emojiArt.emojis[index].x += Int(offset.width)
        emojiArt.emojis[index].y += Int(offset.height)
    }
    
    func scaleEmoji(_ emoji: EmojiArt.Emoji, by scale: CGFloat) {
        let index = emojiArt.emojis.firstIndex{ $0.id == emoji.id }!
        emojiArt.emojis[index].size =
            Int((CGFloat(emojiArt.emojis[index].size) * scale)
                    .rounded(.toNearestOrEven))
    }
    
    func setBackgroundURL(_ url: URL?) {
        emojiArt.backgroundURL = url?.imageURL
        fetchBackgroundImageData()
    }
    
    private func fetchBackgroundImageData() {
        backgroundImage = nil
        if let url = emojiArt.backgroundURL {
            DispatchQueue.global(qos: .userInitiated).async {
                if let imageData = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        if url == self.emojiArt.backgroundURL {
                            self.backgroundImage = UIImage(data: imageData)
                        }
                    }
                }
            }
        }
    }
}

extension EmojiArt.Emoji {
    var fontSize: CGFloat { CGFloat(size) }
    var location: CGPoint { CGPoint(x: CGFloat(x), y: CGFloat(y)) }
}
