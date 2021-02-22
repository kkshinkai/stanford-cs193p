//
//  Cardify.swift
//  Memorize
//
//  Created by Kk Shinkai on 2021/2/22.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var isFaceUp: Bool { rotation < 90 }
    var rotation: Double
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)
                content
            }.opacity(isFaceUp ? 1 : 0)
            Group {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill()
            }.opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: (0, 1, 0))
    }
    
    // MARK: - Drawing Constants
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
}


extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
