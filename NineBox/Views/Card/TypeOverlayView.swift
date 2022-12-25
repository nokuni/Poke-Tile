//
//  TypeOverlayView.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 25/12/22.
//

import SwiftUI

struct TypeOverlayView: View {
    var card: Card
    var amount: CGFloat
    var size: CGSize
    var body: some View {
        ZStack {
            if card.isPokemon {
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
}

struct TypeOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        TypeOverlayView(card: Card.empty, amount: 0, size: CGSize.screen)
    }
}
