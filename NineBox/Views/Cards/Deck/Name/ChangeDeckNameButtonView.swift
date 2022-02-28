//
//  ChangeDeckNameButtonView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import SwiftUI

struct ChangeDeckNameButtonView: View {
    @Binding var isShowingNameAlert: Bool
    @Binding var name: String
    var index: Int
    var body: some View {
        Button(action: {
            isShowingNameAlert.toggle()
        }) {
            HStack {
                Text(name)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        Color.steelBlue
                            .cornerRadius(5)
                    )
                Image(systemName: "pencil.circle")
                    .foregroundColor(.steelBlue)
                    .font(.system(size: 35, weight: .regular, design: .rounded))
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct ChangeDeckNameButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeDeckNameButtonView(isShowingNameAlert: .constant(false), name: .constant("Deck"), index: 0)
    }
}
