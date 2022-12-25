//
//  StatsOverlayView.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 25/12/22.
//

import SwiftUI

struct StatsOverlayView: View {
    var card: Card
    var amount: CGFloat
    var size: CGSize
    var isPossessing: ((Card) -> Bool)?
    var body: some View {
        ZStack {
            if !(isPossessing?(card) ?? true) {
                EmptyView()
            } else {
                if card.isPokemon {
                    ZStack {
                        StatsView(card: card)
                            .frame(width: size.width * (1/amount), height: size.width * (1/amount), alignment: .topLeading)
                    }
                    .scaleEffect(0.5)
                    .frame(width: size.width * (1.42/amount), height: size.width * (1.42/amount), alignment: .topLeading)
                }
            }
        }
    }
}

struct StatsOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        StatsOverlayView(card: Card.empty, amount: 0, size: CGSize.screen)
    }
}
