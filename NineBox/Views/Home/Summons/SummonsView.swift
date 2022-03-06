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
    @State var cards = [Card]()
    @State var previousCardCollection = [Card]()
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.summons)
                    BoosterListView(gameVM: gameVM, size: geo.size, selectedBooster: $selectedBooster, cards: $cards, previousCardCollection: $previousCardCollection)
                    BackButtonView(size: geo.size, dismiss: dismiss)
                }
            }
            .padding()
            
            if selectedBooster != nil {
                CardSummonAnimationView(cards: cards, previousCardCollection: previousCardCollection, size: CGSize.screen, selectedBooster: $selectedBooster, isCardInDeck: gameVM.isCardInDeck, isCardDuplicate: gameVM.isCardDuplicate)
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
