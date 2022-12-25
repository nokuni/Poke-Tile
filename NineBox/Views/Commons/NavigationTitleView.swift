//
//  NavigationTitleView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 24/02/2022.
//

import SwiftUI

struct NavigationTitleView: View {
    var size: CGSize
    var navigationTitle: String
    var specialImage: String?
    var specialColor: Color?
    var region: WorldRegion?
    var body: some View {
        HStack {
            switch true {
            case specialImage != nil:
                Image(specialImage!)
                    .resizable()
                    .frame(width: size.width * 0.09, height: size.width * 0.09)
            case region == nil:
                Image(navigationTitle)
                    .resizable()
                    .frame(width: size.width * 0.09, height: size.width * 0.09)
            default:
                Image(region!.icon)
                    .resizable()
                    .frame(width: size.width * 0.09, height: size.width * 0.09)
            }
            Text(region == nil ? navigationTitle.capitalized : region!.title)
                .foregroundColor(.white)
                .font(.system(size: size.width * 0.07, weight: .semibold, design: .rounded))
        }
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(specialColor != nil ? specialColor! : region == nil ? .mediumBlueApp : region!.debuff.type.color)
                .cornerRadius(5)
        )
    }
}

struct NavigationTitleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTitleView(size: CGSize.screen, navigationTitle: "adventure")
    }
}
