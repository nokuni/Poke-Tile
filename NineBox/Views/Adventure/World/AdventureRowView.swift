//
//  AdventureRowView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 14/03/2022.
//

import SwiftUI

struct AdventureRowView: View {
    var text: String
    var image: String
    var colorBorder: Color
    var size: CGSize
    var body: some View {
        Image(image)
            .resizable()
            .centerCropped(radius: 5, alignment: .center)
            .padding(5)
            .frame(width: size.width, height: size.height * 0.3)
            .background(
                colorBorder
                    .cornerRadius(5)
                    .frame(width: size.width, height: size.height * 0.3)
            )
            .overlay(
                Text(text)
                    .foregroundColor(.white)
                    .font(.system(size: size.width * 0.2, weight: .bold, design: .rounded))
                    .shadow(color: .black, radius: 0, x: 2, y: 2)
            )
    }
}

struct AdventureRowView_Previews: PreviewProvider {
    static var previews: some View {
        AdventureRowView(text: "WORLD", image: "forest.background", colorBorder: .steelBlue, size: CGSize.screen)
    }
}
