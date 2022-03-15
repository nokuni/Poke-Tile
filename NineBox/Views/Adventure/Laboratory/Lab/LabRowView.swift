//
//  LabRowView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 14/03/2022.
//

import SwiftUI

struct LabRowView: View {
    var lab: LabModel
    var size: CGSize
    var body: some View {
        Image(lab.image)
            .resizable()
            .centerCropped(radius: 5, alignment: .center)
            .padding(5)
            .frame(width: size.width, height: size.height * 0.2)
            .background(
                Color.flyingBorder
                    .cornerRadius(5)
                    .frame(width: size.width, height: size.height * 0.2)
            )
            .overlay(
                Text(lab.title)
                    .foregroundColor(.white)
                    .font(.system(size: size.width * 0.1, weight: .bold, design: .rounded))
                    .shadow(color: .black, radius: 0, x: 2, y: 2)
            )
            .overlay(
                ZStack {
                    if !lab.isUnlocked {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(.black.opacity(0.5))
                        Image("lock")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .frame(width: size.width * 0.1, height: size.width * 0.1)
                    }
                }
            )
    }
}

struct LabRowView_Previews: PreviewProvider {
    static var previews: some View {
        LabRowView(lab: LabModel.all[0], size: CGSize.screen)
    }
}
