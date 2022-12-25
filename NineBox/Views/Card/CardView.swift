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
    var isPossessing: ((Card) -> Bool)?
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .stroke(card.borderColor, lineWidth: 3)
            .strokeText(color: card.side == .user ? .blue : card.side == .opponent ? .red : .clear)
            //.shadow(color: card.side == .user ? .blue : card.side == .opponent ? .red : .clear, radius: 3)
            .overlay(
                CardBackgroundView(card: card, isPossessing: isPossessing)
                    .clipped()
                    .cornerRadius(5)
            )
            .padding(5)
            .frame(width: size.height * (1/amount) * 0.48, height: size.height * (1/amount) * 0.48)
//            .overlay(StatsOverlayView(card: card, amount: amount, size: size, isPossessing: isPossessing))
//            .overlay(TypeOverlayView(card: card, amount: amount, size: size))
//            .overlay(CostOverlayView(card: card, amount: amount, size: size))
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.pokemons[2], size: CGSize.screen, amount: 4)
    }
}
