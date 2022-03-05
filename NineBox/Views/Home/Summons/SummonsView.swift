//
//  SummonsView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

struct SummonsView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var gameVM: GameViewModel
    @State var isShowingSummons = false
    @State var selectedBooster: Booster? = nil
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.summons)
                    BoosterListView(gameVM: gameVM, size: geo.size, selectedBooster: $selectedBooster)
                    BackButtonView(size: geo.size, dismiss: dismiss)
                }
            }
            .padding()
            
            if let selectedBooster = selectedBooster {
                CardSummonAnimationView(cards: selectedBooster.cards, size: CGSize.screen, selectedBooster: $selectedBooster, isCardInDeck: gameVM.isCardInDeck)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct SummonsView_Previews: PreviewProvider {
    static var previews: some View {
        SummonsView(gameVM: GameViewModel())
    }
}
