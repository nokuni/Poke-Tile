//
//  CostOverlayView.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 25/12/22.
//

import SwiftUI

struct CostOverlayView: View {
    var card: Card
    var amount: CGFloat
    var size: CGSize
    var body: some View {
        ZStack {
            if card.isPokemon {
                ZStack {
                    Circle()
                        .foregroundColor(.lead)
                        .frame(width: size.width * (0.4/amount), height: size.width * (0.4/amount), alignment: .topLeading)
                    Text("\(card.cost)")
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }
                .scaleEffect(0.5)
                .frame(width: size.width * (1.1/amount), height: size.width * (1.1/amount), alignment: .topTrailing)
            }
        }
    }
}

struct CostOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        CostOverlayView(card: Card.empty, amount: 0, size: CGSize.screen)
    }
}
