//
//  BoosterListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 03/03/2022.
//

import SwiftUI

struct BoosterListView: View {
    @ObservedObject var userVM: UserViewModel
    var size: CGSize
    @Binding var selectedBooster: Booster?
    @Binding var cards: [Card]
    @Binding var previousCardCollection: [Card]
    var boosters: [Booster] {
        return userVM.user.boosters.uniqued()
    }
    var body: some View {
        ScrollView {
            VStack {
                if !userVM.user.boosters.isEmpty {
                    ForEach(boosters.indices, id: \.self) { index in
                        BoosterRowView(booster: userVM.user.boosters[index], userVM: userVM, size: size, selectedBooster: $selectedBooster , cards: $cards, previousCardCollection: $previousCardCollection)
                    }
                }
            }
        }
    }
}

struct BoosterListView_Previews: PreviewProvider {
    static var previews: some View {
        BoosterListView(userVM: UserViewModel(), size: CGSize.screen, selectedBooster: .constant(nil), cards: .constant([]), previousCardCollection: .constant([]))
    }
}
