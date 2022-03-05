//
//  UserDeckRowView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 03/03/2022.
//

import SwiftUI

struct UserDeckRowView: View {
    var deck: Deck
    var size: CGSize
    var body: some View {
        Image(deck.background)
            .resizable()
            .centerCropped(radius: 5, alignment: .center)
            .frame(height: size.height * 0.2)
            .overlay(
                UserDeckBackgroundView(deck: deck, size: size)
            )
    }
}

struct UserDeckRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserDeckRowView(deck: Deck.empty, size: CGSize.screen)
    }
}
