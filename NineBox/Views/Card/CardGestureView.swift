//
//  CardGestureView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 18/02/2022.
//

import SwiftUI

struct CardGestureView: View {
    @State var dragAmount: CGSize = .zero
    @Binding var isRotating: Bool
    
    var size: CGSize
    var card: Card
    var index: Int
    
    var cardDropped: ((CGPoint, Int, Card) -> Void)?
    var isCardInDeck: ((Card) -> Bool)?
    var isPossessing: ((Card) -> Bool)?
    
    var gesture: some Gesture {
        DragGesture(coordinateSpace: .global)
            .onChanged {
                dragAmount = CGSize(width: $0.translation.width, height: $0.translation.height)
            }
            .onEnded {
                cardDropped?($0.location, index, card)
                dragAmount = .zero
            }
    }
    var body: some View {
        CardView(card: card, size: size, amount: 4, isPossessing: isPossessing)
            .offset(dragAmount)
            .gesture(gesture)
            .rotation3DEffect(.degrees(isRotating ? 180 : 0), axis: (x: 0, y: 1, z: 0))
            .zIndex(dragAmount == .zero ? 0 : 1)
            .disabled(!card.isActivated)
    }
}

struct CardGestureView_Previews: PreviewProvider {
    static var previews: some View {
        CardGestureView(isRotating: .constant(false), size: CGSize.screen, card: Card.pokemons[0], index: 0)
    }
}
