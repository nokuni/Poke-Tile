//
//  CommonBackgroundView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 01/03/2022.
//

import SwiftUI

struct CommonBackgroundView: View {
    private let grid = [GridItem](repeating: .init(.flexible(), spacing: 0), count: 2)
    var randomPokemons: [Card] {
        return Card.pokemons.differentRandomElements(amount: 8)
    }
    var body: some View {
        GeometryReader { geo in
            LazyVGrid(columns: grid) {
                ForEach(randomPokemons) { pokemon in
                    Image(pokemon.image)
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .opacity(0.05)
                }
            }
        }
    }
}

struct CommonBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        CommonBackgroundView()
    }
}
