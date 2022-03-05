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
        VStack {
            Text(deck.name)
                .foregroundColor(.black)
                .font(.system(size: size.width * 0.05, weight: .bold, design: .rounded))
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(
                    Color.white.cornerRadius(5)
                )
                .padding(.horizontal, 8)
                .frame(maxWidth: .infinity, maxHeight: size.height * 0.05, alignment: .top)
                .padding(.top, 10)
            HStack {
                ForEach(deck.types, id: \.self) { type in
                    Image(type)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.8)
                }
            }
        }
    }
}

struct UserDeckBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        UserDeckBackgroundView(deck: Deck.all[0], size: CGSize.screen)
    }
}
