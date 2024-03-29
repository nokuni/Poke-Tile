//
//  CardBackgroundView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 17/02/2022.
//

import SwiftUI

struct CardBackgroundView: View {
    private let columns = [GridItem](repeating: .init(.flexible()), count: 2)
    var card: Card
    var isPossessing: ((Card) -> Bool)?
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .topLeading) {
                card.type.color
                    .cornerRadius(5)
                    .brightness(0.4)
                    .opacity(1)
                Image(card.backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(5)
                    .opacity(0.5)
                if card.category == .pokemon {
                    Image(card.image)
                        .resizable()
                        .renderingMode(!(isPossessing?(card) ?? true) ? .template : .none)
                        .centerCropped(radius: 5, alignment: .center)
                        .foregroundColor(.black)
                        .frame(width: geo.size.width * 1.3, height: geo.size.height * 1.3)
                }
                if !card.debuffs.isEmpty {
                    LazyVGrid(columns: columns) {
                        ForEach(card.debuffs.indices, id: \.self) { index in
                            Image(card.image)
                                .resizable()
                                .scaledToFit()
                                .scaleEffect(0.7)
                        }
                    }
                } else {
                    if card.category != .pokemon {
                        Image(card.image)
                            .resizable()
                            .renderingMode(card.image == "pokeball" ? .none : .template)
                            .foregroundColor(card.image == "pokeball" ? .white : .clear)
                            .scaleEffect(0.4)
                            .opacity(0.8)
                    }
                }
            }
            .scaledToFit()
            .foregroundColor(Color(UIColor.systemGray4))
        }
    }
}

struct CardBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        CardBackgroundView(card: Card.pokemons[0])
    }
}
