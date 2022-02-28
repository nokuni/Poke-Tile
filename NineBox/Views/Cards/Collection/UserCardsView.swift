//
//  UserCardsView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 23/02/2022.
//

import SwiftUI

struct UserCardsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var gameVM = GameViewModel()
    private let grid = [GridItem](repeating: .init(.flexible(), spacing: 25), count: 4)
    var body: some View {
        ZStack {
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: .pokemons)
                    UserCardListView(size: geo.size, gameVM: gameVM)
                    BackButtonView(size: geo.size, dismiss: dismiss)
                }
            }
            .padding()
        }
    }
}

struct UserCardsView_Previews: PreviewProvider {
    static var previews: some View {
        UserCardsView()
    }
}
