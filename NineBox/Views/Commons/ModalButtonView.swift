//
//  ModalButtonView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 02/03/2022.
//

import SwiftUI

struct ModalButtonView: View {
    @Binding var isPresented: Bool
    var borderColor: Color
    var backgroundColor: Color
    var textColor: Color
    var textContent: String
    var size: CGSize
    var body: some View {
        Button(action: {
            isPresented.toggle()
        }) {
            RoundedRectangle(cornerRadius: 5)
                .stroke(borderColor, lineWidth: 2)
                .frame(maxWidth: .infinity, maxHeight: size.width * 0.1)
                .background(backgroundColor.cornerRadius(5))
                .overlay(
                    Text(textContent)
                        .foregroundColor(textColor)
                        .font(.system(size: size.width * 0.05, weight: .semibold, design: .rounded))
                )
        }
        .zIndex(-1)
    }
}

struct ModalButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ModalButtonView(isPresented: .constant(false), borderColor: .black, backgroundColor: .crimson, textColor: .white, textContent: "EXAMPLE", size: CGSize.screen)
    }
}
