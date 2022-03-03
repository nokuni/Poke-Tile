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
    var body: some View {
        ScrollView {
            VStack {
                if !gameVM.user.boosters.isEmpty {
                    ForEach(gameVM.user.boosters.indices) { index in
                        BoosterRowView(booster: gameVM.user.boosters[index], gameVM: gameVM, size: size, selectedBooster: $selectedBooster)
                    }
                }
            }
        }
    }
}

struct BoosterListView_Previews: PreviewProvider {
    static var previews: some View {
        BoosterListView(gameVM: GameViewModel(), size: CGSize.screen, selectedBooster: .constant(nil))
    }
}
