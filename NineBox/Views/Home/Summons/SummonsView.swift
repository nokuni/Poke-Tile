//
//  SummonsView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

struct SummonsView: View {
    @ObservedObject var gameVM: GameViewModel
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.summons)
                    .padding(.leading)
                BoosterListView(gameVM: gameVM, size: geo.size)
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
