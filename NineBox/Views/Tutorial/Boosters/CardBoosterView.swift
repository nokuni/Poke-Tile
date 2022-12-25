//
//  CardBoosterView.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 25/12/22.
//

import SwiftUI

struct CardBoosterView: View {
    var deck: Deck
    var size: CGSize
    var body: some View {
        Image(deck.background)
            .resizable()
            .centerCropped(radius: 5, alignment: .center)
            .frame(maxWidth: size.width, maxHeight: size.width)
            .overlay(
                CardBoosterOverlay(deck: deck)
            )
    }
}

struct CardBoosterView_Previews: PreviewProvider {
    static var previews: some View {
        CardBoosterView(deck: Deck.all[0], size: CGSize.screen)
    }
}
