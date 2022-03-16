//
//  PuzzleView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 14/03/2022.
//

import SwiftUI

struct PuzzleView: View {
    @Binding var isActive: Bool
    var body: some View {
        Text("Hello, World!")
    }
}

struct PuzzleView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleView(isActive: .constant(false))
    }
}
