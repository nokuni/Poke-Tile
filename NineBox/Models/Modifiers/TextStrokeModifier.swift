//
//  TextStrokeModifier.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 25/12/22.
//

import SwiftUI

struct TextStrokeModifier: ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        content
            .shadow(color: color, radius: 0.4)
            .shadow(color: color, radius: 0.4)
            .shadow(color: color, radius: 0.4)
            .shadow(color: color, radius: 0.4)
            .shadow(color: color, radius: 0.4)
            .shadow(color: color, radius: 0.4)
            .shadow(color: color, radius: 0.4)
            .shadow(color: color, radius: 0.4)
            .shadow(color: color, radius: 0.4)
            .shadow(color: color, radius: 0.4)
    }
}
