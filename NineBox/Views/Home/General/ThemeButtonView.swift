//
//  ThemeButtonView.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 25/12/22.
//

import SwiftUI

struct ThemeButtonView: View {
    @Binding var isShowingModalTheme: Bool
    var size: CGSize
    var body: some View {
        Button(action: {
            isShowingModalTheme.toggle()
        }) {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.steelBlue, lineWidth: 3)
                .frame(width: size.width * 0.1, height: size.width * 0.1, alignment: .trailing)
                .background(Color.white.cornerRadius(5))
                .overlay(
                    Image("025")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.steelBlue)
                        .scaledToFit()
                        .scaleEffect(0.8)
                )
                .padding(.trailing)
                .frame(width: size.width, alignment: .trailing)
        }
    }
}

struct ThemeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeButtonView(isShowingModalTheme: .constant(false), size: CGSize.screen)
    }
}
