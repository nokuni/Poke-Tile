//
//  StatsView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 17/02/2022.
//

import SwiftUI

struct StatsView: View {
    private let grid = [GridItem](repeating: .init(.flexible(), spacing: 0), count: 3)
    var card: Card
    var body: some View {
        GeometryReader { geo in
            LazyVGrid(columns: grid, spacing: 0) {
                ForEach(0..<9) { index in
                    StatSquareView(size: geo.size, index: index, card: card)
                }
            }
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(card: Card.pokemons[0])
    }
}
