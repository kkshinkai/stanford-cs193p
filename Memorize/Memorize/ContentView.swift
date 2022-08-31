import SwiftUI

struct ContentView: View {
    var emojis = ["🍇", "🍈", "🍉", "🍊", "🍋", "🍌", "🍍", "🥭",
                  "🍎", "🍏", "🍐", "🍑", "🍒", "🍓", "🫐", "🥝",
                  "🍅", "🫒", "🥥", "🥑", "🍆", "🥔", "🥕", "🌽"]
    @State var emojiCount = 20

    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(emoji: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    var emoji: String
    
    // `@State` is not just a way to make variables mutable, it
    // turns `isFaceUp` into a pointer to a Boolean.
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(emoji).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
            .previewInterfaceOrientation(.portrait)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
