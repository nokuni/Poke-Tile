//
//  StarterBoosterListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 03/03/2022.
//

import SwiftUI

struct StarterBoosterListView: View {
    var starters: [Deck]
    var size: CGSize
    @Binding var selectedDeck: Deck?
    var body: some View {
        HStack {
            ForEach(starters.indices, id: \.self) { index in
                VStack {
                    PointingArrowView(color: .white, size: size)
                        .opacity(selectedDeck == starters[index] ? 1 : 0)
                        .padding()
                    Button(action: {
                        selectedDeck = starters[index]
                    }) {
                        CardBoosterView(deck: starters[index], size: size)
                            .shadow(color: selectedDeck == starters[index] ? .white : .clear, radius: 5)
                            .shadow(color: selectedDeck == starters[index] ? .white : .clear, radius: 5)
                    }
                }
            }
        }
    }
}

struct StarterBoosterListView_Previews: PreviewProvider {
    static var previews: some View {
        StarterBoosterListView(starters: [], size: CGSize.screen, selectedDeck: .constant(nil))
    }
}

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
