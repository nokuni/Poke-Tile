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
    var view: V
    
    init(size: CGSize, item: HomeItem, @ViewBuilder view: @escaping () -> V) {
        self.size = size
        self.item = item
        self.view = view()
    }
    
    var body: some View {
        NavigationLink(destination: view) {
            HomeItemView(size: size, item: item)
        }
    }
}
struct HomeNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavigationLink(size: CGSize.screen, item: HomeItem.summons, view: { EmptyView() })
    }
}
