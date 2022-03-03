//
//  DeckBackgroundView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 03/03/2022.
//

import SwiftUI

struct UserDeckBackgroundView: View {
    var deck: Deck
    var size: CGSize
    var body: some View {
        ZStack {
            Image(deck.background)
                .resizable()
                .centerCropped(radius: 5, alignment: .center)
            HStack {
                Text(deck.name)
                    .foregroundColor(.black)
                    .font(.system(size: size.width * 0.05, weight: .bold, design: .rounded))
                ForEach(deck.types, id: \.self) { type in
                    Image(type)
                        .resizable()
                        .frame(width: size.width * 0.05, height: size.width * 0.05)
                }
            }
            .frame(maxWidth: .infinity)
            .background(
                Color.white.cornerRadius(5)
            )
            .padding(.horizontal, 8)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.top, 5)
        }
    }
}

struct UserDeckBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        UserDeckBackgroundView(deck: Deck.empty, size: CGSize.screen)
    }
}
