//
//  AdventureRowView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 17/02/2022.
//

import SwiftUI

struct RegionRowView: View {
    var size: CGSize
    var region: WorldRegion
    var body: some View {
        Image(region.image)
            .resizable()
            .centerCropped(radius: 5, alignment: .center)
            .padding(5)
            .frame(width: size.width, height: size.height * 0.2)
            .background(
                region.debuff.borderColor
                    .cornerRadius(5)
                    .frame(width: size.width, height: size.height * 0.2)
            )
            .overlay(
                RegionBackgroundView(size: size, title: region.title, region: region)
            )
    }
}

struct RegionRowView_Previews: PreviewProvider {
    static var previews: some View {
        RegionRowView(size: CGSize.screen, region: WorldRegion.regions[0])
    }
}
