//
//  AdventureRowView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 14/03/2022.
//

import SwiftUI

struct AdventureRowView: View {
    var adventure: AdventureModel
    var size: CGSize
    var body: some View {
        Image(adventure.image)
            .resizable()
            .centerCropped(radius: 5, alignment: .center)
            .padding(5)
            .frame(width: size.width, height: size.height * 0.3)
            .background(
                adventure.color
                    .cornerRadius(5)
                    .frame(width: size.width, height: size.height * 0.3)
            )
            .overlay(
                Text(adventure.title)
                    .foregroundColor(.white)
                    .font(.system(size: size.width * 0.15, weight: .bold, design: .rounded))
                    .shadow(color: .black, radius: 0, x: 2, y: 2)
            )
            .overlay(
                ZStack {
                    if !adventure.isUnlocked {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(.black.opacity(0.5))
                        Image(systemName: "lock.fill")
                            .foregroundColor(.white)
                            .font(.system(size: size.width * 0.2, weight: .bold, design: .rounded))
                    }
                }
            )
    }
}

struct AdventureRowView_Previews: PreviewProvider {
    static var previews: some View {
        AdventureRowView(adventure: AdventureModel.lab, size: CGSize.screen)
    }
}
