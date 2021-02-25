//
//  OptionalImage.swift
//  EmojiArt
//
//  Created by Kk Shinkai on 2021/2/26.
//

import SwiftUI

struct OptionalImage: View {
    var uiImage: UIImage?
    
    var body: some View {
        Group {
            if uiImage != nil {
                Image(uiImage: uiImage!)
            }
        }
    }
}
