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
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.summons)
                        .padding(.leading)
                    BoosterListView(gameVM: gameVM, size: geo.size, selectedBooster: $selectedBooster)
                    BackButtonView(size: geo.size, dismiss: dismiss)
                        .padding(.leading)
                }
            }
            
            if gameVM.user.boosters.isEmpty {
                Text("No boosters")
                    .foregroundColor(Color(UIColor.systemGray4))
                    .font(.system(size: CGSize.screen.width * 0.1, weight: .bold, design: .rounded))
            }
            
            if let selectedBooster = selectedBooster {
                CardSummonAnimationView(cards: selectedBooster.cards, size: CGSize.screen, selectedBooster: $selectedBooster)
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
