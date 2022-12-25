//
//  MainMenuButtonView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 16/03/2022.
//

import SwiftUI

struct MainMenuButtonView: View {
    var size: CGSize
    @Binding var isActive: Bool
    var body: some View {
        Button(action: {
            isActive = false
        }) {
            Image("house")
                .resizable()
                .frame(width: size.width * 0.1, height: size.width * 0.1)
                .frame(width: size.width * 0.15, height: size.width * 0.15)
                .background(
                    Color.mediumBlueApp
                        .cornerRadius(5)
                        .strokeText(color: .steelBlue)
                )
        }
    }
}

struct MainMenuButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuButtonView(size: CGSize.screen, isActive: .constant(false))
    }
}
