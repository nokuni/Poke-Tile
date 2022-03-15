//
//  AdventureNavigationLink.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 14/03/2022.
//

import SwiftUI

struct AdventureNavigationLink<V: View>: View {
    var adventure: AdventureModel
    var size: CGSize
    var view: V
    init(adventure: AdventureModel, size: CGSize, @ViewBuilder view: @escaping () -> V) {
        self.adventure = adventure
        self.size = size
        self.view = view()
    }
    var body: some View {
        NavigationLink(destination: view) {
            AdventureRowView(adventure: adventure, size: size)
        }
        .disabled(!adventure.isUnlocked)
    }
}


struct AdventureNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        AdventureNavigationLink(adventure: AdventureModel.lab, size: CGSize.screen, view: { })
    }
}
