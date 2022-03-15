//
//  AdventureNavigationLink.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 14/03/2022.
//

import SwiftUI

struct AdventureNavigationLink<V: View>: View {
    var text: String
    var image: String
    var colorBorder: Color
    var size: CGSize
    var view: V
    init(text: String, image: String, colorBorder: Color, size: CGSize, @ViewBuilder view: @escaping () -> V) {
        self.text = text
        self.image = image
        self.colorBorder = colorBorder
        self.size = size
        self.view = view()
    }
    var body: some View {
        NavigationLink(destination: view) {
            AdventureRowView(text: text, image: image, colorBorder: colorBorder, size: size)
        }
    }
}


struct AdventureNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        AdventureNavigationLink(text: "", image: "", colorBorder: .black, size: CGSize.screen, view: { })
    }
}
