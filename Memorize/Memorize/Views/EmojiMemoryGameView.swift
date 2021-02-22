//
//  ContentView.swift
//  Memorize
//
//  Created by Kk Shinkai on 2021/2/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.75)) {
                        viewModel.choose(card: card)
                    }
                }
                .padding(5)
            }
            .foregroundColor(.orange)
            .padding()
            Button {
                withAnimation(.easeOut) {
                    viewModel.resetGame()
                }
            } label: { Text("New Game") }
        }
    }
}

struct CardView: View {
    var card: Game.Card
    
    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Group {
                        if card.isConsumingBonusTime {
                            Pie(startAngle: .degrees(-90),
                                endAngle: .degrees(-animatedBonusRemaining * 360 - 90))
                                .onAppear { startBonusTimeAnimation() }
                        } else {
                            Pie(startAngle: .degrees(-90),
                                endAngle: .degrees(-card.bounsRemaining * 360 - 90))
                        }
                    }
                    .padding(5)
                    .opacity(0.4)
                    .transition(.identity)
                    Text(card.content)
                        .font(.system(size: fontSize(for: geometry.size)))
                        .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                        .animation(card.isMatched
                                    ? Animation.linear(duration: 1).repeatForever(autoreverses: false)
                                    : .default)
                }
                .cardify(isFaceUp: card.isFaceUp)
                .transition(AnyTransition.scale)
            }
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bounsRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    // MARK: - Drawing Constants and Calculators
    
    private let fontScaleFactor: CGFloat = 0.7
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
