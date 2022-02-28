//
//  CardView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 17/02/2022.
//

import SwiftUI

struct CardView: View {
    var card: Card
    var size: CGSize
    var amount: CGFloat
    
    var statsOverlay: some View {
        ZStack {
            StatsView(card: card)
                .frame(width: size.width * (1/amount), height: size.width * (1/amount), alignment: .topLeading)
        }
        .scaleEffect(0.5)
        .frame(width: size.width * (1.42/amount), height: size.width * (1.42/amount), alignment: .topLeading)
    }
    var overlayType: some View {
        ZStack {
            if card.category == .pokemon {
                ZStack {
                    Image(card.backgroundImage)
                        .resizable()
                        .frame(width: size.width * (0.4/amount), height: size.width * (0.4/amount), alignment: .topLeading)
                }
                .scaleEffect(0.5)
                .frame(width: size.width * (1.1/amount), height: size.width * (1.1/amount), alignment: .bottomTrailing)
            }
        }
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .stroke(card.borderColor, lineWidth: 2)
            .background(
                CardBackgroundView(card: card)
                    .clipped()
            )
            .padding(5)
            .frame(width: size.width * (1/amount), height: size.width * (1/amount))
            .overlay(statsOverlay)
            .overlay(overlayType)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.pokemons[0], size: CGSize.screen, amount: 4)
    }
}
