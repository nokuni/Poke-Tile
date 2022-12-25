//
//  SpacedScreenModifier.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 25/12/22.
//

import SwiftUI

struct SpacedScreenModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}
