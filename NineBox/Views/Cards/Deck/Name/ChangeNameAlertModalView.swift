//
//  ChangeNameAlertModalView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import SwiftUI

struct ChangeNameAlertModalView: View {
    @Binding var isShowingNameAlert: Bool
    @Binding var name: String
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.black
                    .opacity(0.5)
                    .ignoresSafeArea()
                VStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.white)
                        .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.4)
                        .overlay(
                            ChangeNameOverlayView(isShowingNameAlert: $isShowingNameAlert, name: $name, size: geo.size)
                        )
                    Spacer()
                }
                .padding(.top)
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct ChangeNameAlertModalView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeNameAlertModalView(isShowingNameAlert: .constant(false), name: .constant(""))
    }
}
