//
//  LabNavigationLink.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 14/03/2022.
//

import SwiftUI

struct LabNavigationLink<V: View>: View {
    var text: String
    var image: String
    var size: CGSize
    var view: V
    init(text: String, image: String, size: CGSize, @ViewBuilder view: @escaping () -> V) {
        self.text = text
        self.image = image
        self.size = size
        self.view = view()
    }
    var body: some View {
        NavigationLink(destination: view) {
            LabRowView(text: text, image: image, size: size)
        }
    }
}

struct LabNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        LabNavigationLink(text: "", image: "", size: CGSize.screen, view: { })
    }
}
