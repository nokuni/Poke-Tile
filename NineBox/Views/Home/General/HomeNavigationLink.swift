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
    @Binding var isActive: Bool
    var view: V
    
    init(size: CGSize, item: HomeItem, theme: Theme, isActive: Binding<Bool>, @ViewBuilder view: @escaping () -> V) {
        self.size = size
        self.item = item
        self.theme = theme
        self._isActive = isActive
        self.view = view()
    }
    
    var body: some View {
        VStack {
            NavigationLink(destination: view, isActive: $isActive) {
                HomeItemView(size: size, item: item, theme: theme)
            }
            .isDetailLink(false)
            .disabled(!item.isUnlocked)
        }
    }
}
struct HomeNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavigationLink(size: CGSize.screen, item: HomeItem.cards, theme: Theme.pikachu, isActive: .constant(false), view: { EmptyView() })
    }
}
