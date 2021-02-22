//
//  Grid.swift
//  Memorize
//
//  Created by Kk Shinkai on 2021/2/21.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    private var items: [Item]
    private var content: (Item) -> ItemView
    
    init(_ items: [Item], content: @escaping (Item) -> ItemView) {
        self.items = items
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let layout = GridLayout(itemCount: items.count, in: geometry.size)
            ForEach(items) { item in
                let index = items.firstIndex{ $0.id == item.id }!
                content(item)
                    .frame(width: layout.itemSize.width,
                           height: layout.itemSize.height)
                    .position(layout.location(ofItemAt: index))
            }
        }
    }
}

//struct Grid_Previews: PreviewProvider {
//    static var previews: some View {
//        Grid()
//    }
//}
