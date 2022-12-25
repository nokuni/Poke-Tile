//
//  ViewExtension.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import SwiftUI

extension View {
    
    func placeholder<Content: View>(when shouldShow: Bool, alignment: Alignment = .leading, @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    var spacedScreen: some View {
        modifier(SpacedScreenModifier())
    }
    
    func limitText(_ upper: Int, text: inout String) {
        if text.count > upper {
            text = String(text.prefix(upper))
        }
    }
    
    func strokeText(color: Color) -> some View {
        modifier(TextStrokeModifier(color: color))
    }
}
