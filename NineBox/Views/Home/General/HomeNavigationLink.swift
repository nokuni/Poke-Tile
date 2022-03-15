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
            if isShowing {
                PointingArrowView(color: .steelBlue, size: size)
                    .scaleEffect(1.5)
                    .frame(width: size.width * 0.2, height: size.width * 0.2)
            } else {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.clear)
                    .frame(width: size.width * 0.2, height: size.width * 0.2)
            }
            NavigationLink(destination: view) {
                HomeItemView(size: size, item: item, theme: theme)
            }
            .disabled(!item.isUnlocked)
        }
    }
}
struct HomeNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavigationLink(size: CGSize.screen, item: HomeItem.cards, theme: Theme.pikachu, isShowing: false, view: { EmptyView() })
    }
}
