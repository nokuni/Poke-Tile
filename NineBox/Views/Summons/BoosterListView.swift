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
    var body: some View {
        ScrollView {
            VStack {
                ForEach(gameVM.user.boosters.indices) { index in
                    BoosterRowView(booster: gameVM.user.boosters[index], gameVM: gameVM, size: size)
                }
            }
        }
    }
}

struct BoosterListView_Previews: PreviewProvider {
    static var previews: some View {
        BoosterListView(gameVM: GameViewModel(), size: CGSize.screen)
    }
}
