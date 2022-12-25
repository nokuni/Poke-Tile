//
//  BackButtonView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 24/02/2022.
//

import SwiftUI

struct BackButtonView: View {
    var size: CGSize
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.uturn.left")
                .foregroundColor(Color.white)
                .font(.system(size: size.width * 0.07, weight: .semibold, design: .rounded))
                .frame(width: size.width * 0.15, height: size.width * 0.15)
                .background(
                    Color.mediumBlueApp
                        .cornerRadius(5)
                        .strokeText(color: .steelBlue)
                )
        }
    }
}

struct BackButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BackButtonView(size: CGSize.screen)
    }
}
