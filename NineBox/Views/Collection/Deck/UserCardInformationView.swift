//
//  UserCardInformationView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 05/03/2022.
//

import SwiftUI

struct UserCardInformationView: View {
    var card: Card
    var size: CGSize
    var isPossessing: ((Card) -> Bool)?
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .stroke(card.borderColor, lineWidth: 3)
            .shadow(color: card.side == .user ? .blue : card.side == .opponent ? .red : .clear, radius: 3)
            .background(
                CardBackgroundView(card: card, isPossessing: isPossessing)
                    .clipped()
                    .cornerRadius(5)
            )
            .padding(5)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            //.overlay(StatsOverlayView(card: card, amount: amount, size: size, isPossessing: isPossessing))
            //.overlay(TypeOverlayView(card: card, amount: amount, size: size))
    }
}

struct UserCardInformationView_Previews: PreviewProvider {
    static var previews: some View {
        UserCardInformationView(card: Card.empty, size: CGSize.screen)
    }
}
