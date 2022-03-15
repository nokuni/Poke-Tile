//
//  AdventureRowView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 17/02/2022.
//

import SwiftUI

struct JourneyRowView: View {
    var size: CGSize
    var adventure: Adventure
    var body: some View {
        Image(adventure.image)
            .resizable()
            .centerCropped(radius: 5, alignment: .center)
            .padding(5)
            .frame(width: size.width, height: size.height * 0.2)
            .background(
                adventure.debuff.borderColor
                    .cornerRadius(5)
                    .frame(width: size.width, height: size.height * 0.2)
            )
            .overlay(
                JourneyBackgroundView(size: size, title: adventure.title, adventure: adventure)
            )
    }
}

struct JourneyRowView_Previews: PreviewProvider {
    static var previews: some View {
        JourneyRowView(size: CGSize.screen, adventure: Adventure.adventures[0])
    }
}
