//
//  ViewExtension.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
    var spacedScreen: some View {
        modifier(SpacedScreenModifier())
    }
}

// VIEW MODIFIERS

struct SpacedScreenModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}
