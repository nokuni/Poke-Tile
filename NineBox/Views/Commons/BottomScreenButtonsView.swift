//
//  BottomScreenButtonsView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 16/03/2022.
//

import SwiftUI

struct BottomScreenButtonsView: View {
    var dismiss: DismissAction?
    var size: CGSize
    @Binding var isActive: Bool
    var body: some View {
        HStack {
            BackButtonView(size: size, dismiss: dismiss)
            Spacer()
            MainMenuButtonView(size: size, isActive: $isActive)
        }
    }
}

struct BottomScreenButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        BottomScreenButtonsView(size: CGSize.screen, isActive: .constant(false))
    }
}
