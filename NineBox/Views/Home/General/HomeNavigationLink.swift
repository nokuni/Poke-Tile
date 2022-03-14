//
//  HomeNavigationLink.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

struct HomeNavigationLink<V: View>: View {
    var size: CGSize
    var item: HomeItem
    var theme: Theme
    var isShowing: Bool
    var view: V
    
    init(size: CGSize, item: HomeItem, theme: Theme, isShowing: Bool, @ViewBuilder view: @escaping () -> V) {
        self.size = size
        self.item = item
        self.theme = theme
        self.isShowing = isShowing
        self.view = view()
    }
    
    var body: some View {
        VStack {
            PointingArrowView(size: size)
                //.opacity(isShowing ? 1 : 0)
            NavigationLink(destination: view) {
                HomeItemView(size: size, item: item, theme: theme)
            }
        }
    }
}
struct HomeNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavigationLink(size: CGSize.screen, item: HomeItem.cards, theme: Theme.pikachu, isShowing: false, view: { EmptyView() })
    }
}
