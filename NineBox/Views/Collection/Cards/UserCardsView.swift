//
//  UserCardsView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 23/02/2022.
//

import SwiftUI

struct UserCardsView: View {
    private let grid = [GridItem](repeating: .init(.flexible(), spacing: 25), count: 4)
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.cards.rawValue)
                    UserCardListView(size: geo.size)
                    BackButtonView(size: geo.size)
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct UserCardsView_Previews: PreviewProvider {
    static var previews: some View {
        UserCardsView()
    }
}
