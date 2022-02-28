//
//  BackButtonView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 24/02/2022.
//

import SwiftUI

struct BackButtonView: View {
    var size: CGSize
    var dismiss: DismissAction?
    var body: some View {
        Button(action: {
            dismiss?()
        }) {
            Image(systemName: "arrow.uturn.left")
                .foregroundColor(Color.white)
                .font(.system(size: size.width * 0.07, weight: .semibold, design: .rounded))
                .frame(width: size.width * 0.15, height: size.width * 0.15)
                .background(
                    Color.steelBlue
                        .cornerRadius(5)
                )
        }
    }
}

struct BackButtonView_Previews: PreviewProvider {
    var dismiss: DismissAction
    static var previews: some View {
        BackButtonView(size: CGSize.screen)
    }
}
