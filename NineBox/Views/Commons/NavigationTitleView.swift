//
//  NavigationTitleView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 24/02/2022.
//

import SwiftUI

struct NavigationTitleView: View {
    var size: CGSize
    var navigationTitle: NavigationTitleModel
    var region: WorldRegion?
    var body: some View {
        HStack {
            Image(region == nil ? navigationTitle.rawValue : region!.icon)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.white)
                .frame(width: size.width * 0.09, height: size.width * 0.09)
            Text(region == nil ? navigationTitle.rawValue.capitalized : region!.title)
                .foregroundColor(.white)
                .font(.system(size: size.width * 0.07, weight: .semibold, design: .rounded))
        }
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(region == nil ? navigationTitle.color : region!.debuff.borderColor)
                .cornerRadius(5)
        )
    }
}

struct NavigationTitleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTitleView(size: CGSize.screen, navigationTitle: .adventure)
    }
}
