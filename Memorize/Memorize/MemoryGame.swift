import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: [Card]
    
    init(numberOfPairOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = [Card]()
        
        for index in 0..<numberOfPairOfCards {
            let content = createCardContent(index)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(card: Card) {
    }
    
    struct Card {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
    }
}
