//
//  AdventureRowView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 17/02/2022.
//

import SwiftUI

struct AdventureRowView: View {
    var size: CGSize
    var adventure: Adventure
    var body: some View {
        Image(adventure.image)
            .resizable()
            .centerCropped(radius: 10, alignment: .center)
            .frame(width: size.width, height: size.height * 0.2)
            .overlay(
                AdventureBackgroundView(size: size, title: adventure.title, adventure: adventure)
            )
    }
}

struct AdventureRowView_Previews: PreviewProvider {
    static var previews: some View {
        AdventureRowView(size: CGSize.screen, adventure: Adventure.adventures[0])
    }
}
