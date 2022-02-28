//
//  HomeView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 19/02/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var gameVM: GameViewModel
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack {
                    Spacer()
                    HStack(spacing: 0) {
                        HomeNavigationLink(size: geo.size, item: HomeItem.summons) {
                            SummonsView()
                        }
                        HomeNavigationLink(size: geo.size, item: HomeItem.adventures) {
                            AdventureView()
                        }
                        HomeNavigationLink(size: geo.size, item: HomeItem.pokemons) {
                            UserDeckView(gameVM: gameVM)
                        }
                        HomeNavigationLink(size: geo.size, item: HomeItem.shop) {
                            EmptyView()
                        }
                        HomeNavigationLink(size: geo.size, item: HomeItem.settings) {
                            EmptyView()
                        }
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
