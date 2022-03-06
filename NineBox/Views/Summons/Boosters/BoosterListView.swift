//
//  BoosterListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 03/03/2022.
//

import SwiftUI

struct BoosterListView: View {
    @ObservedObject var gameVM: GameViewModel
    var size: CGSize
    @Binding var selectedBooster: Booster?
    @Binding var cards: [Card]
    @Binding var previousCardCollection: [Card]
    var boosters: [Booster] {
        return gameVM.user.boosters.uniqued()
    }
    var body: some View {
        ScrollView {
            VStack {
                if !gameVM.user.boosters.isEmpty {
                    ForEach(boosters.indices, id: \.self) { index in
                        BoosterRowView(booster: gameVM.user.boosters[index], gameVM: gameVM, size: size, selectedBooster: $selectedBooster , cards: $cards, previousCardCollection: $previousCardCollection)
                    }
                }
            }
        }
    }
}

struct BoosterListView_Previews: PreviewProvider {
    static var previews: some View {
        BoosterListView(gameVM: GameViewModel(), size: CGSize.screen, selectedBooster: .constant(nil), cards: .constant([]), previousCardCollection: .constant([]))
    }
}
