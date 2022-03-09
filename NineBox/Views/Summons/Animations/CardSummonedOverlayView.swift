//
//  CardSummonedOverlayView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 08/03/2022.
//

import SwiftUI

struct CardSummonedOverlayView: View {
    var isRotating: Bool
    var card: Card
    var previousCardCollection: [Card]
    var size: CGSize
    var body: some View {
        ZStack {
            if isRotating == false {
                Text(card.isDuplicate(from: previousCardCollection) ? "Duplicate" : "New card")
                    .foregroundColor(card.isDuplicate(from: previousCardCollection) ? .white : .yellow)
                    .font(.system(size: size.width * 0.03, weight: .bold, design: .rounded))
                    .frame(width: size.width * 0.2, height: size.height * 0.05, alignment: .bottom)
                    .shadow(color: .black, radius: 0, x: 1, y: 1)
            }
        }
    }
}

struct CardSummonedOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        CardSummonedOverlayView(isRotating: false, card: Card.empty, previousCardCollection: [], size: CGSize.screen)
    }
}
