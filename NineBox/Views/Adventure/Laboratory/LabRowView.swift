//
//  LabRowView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 14/03/2022.
//

import SwiftUI

struct LabRowView: View {
    var text: String
    var image: String
    var size: CGSize
    var body: some View {
        Image(image)
            .resizable()
            .centerCropped(radius: 5, alignment: .center)
            .padding(5)
            .frame(width: size.width, height: size.height * 0.2)
            .background(
                Color.steelBlue
                    .cornerRadius(5)
                    .frame(width: size.width, height: size.height * 0.2)
            )
            .overlay(
                Text(text)
                    .foregroundColor(.white)
                    .font(.system(size: size.width * 0.1, weight: .bold, design: .rounded))
                    .shadow(color: .black, radius: 0, x: 2, y: 2)
            )
    }
}

struct LabRowView_Previews: PreviewProvider {
    static var previews: some View {
        LabRowView(text: "", image: "", size: CGSize.screen)
    }
}
