//
//  CardBoosterOverlay.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 25/12/22.
//

import SwiftUI

struct CardBoosterOverlay: View {
    var deck: Deck
    var body: some View {
        VStack {
            Text(deck.name.uppercased())
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(5)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.white, lineWidth: 3)
                        .background(deck.associatedType.color.cornerRadius(5))
                )
                .multilineTextAlignment(.center)
                .padding(.top)
            Image(deck.background)
                .resizable()
                .scaledToFit()
                .padding(5)
                .background(
                    Circle()
                        .foregroundColor(.white)
                )
                .scaleEffect(0.8)
        }
    }
}

struct CardBoosterOverlay_Previews: PreviewProvider {
    static var previews: some View {
        CardBoosterOverlay(deck: Deck.all[0])
    }
}
