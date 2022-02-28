//
//  GameEndingView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 28/02/2022.
//

import SwiftUI

struct GameEndingView: View {
    @Environment(\.dismiss) private var dismiss
    var resetGame: (() -> Void)?
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            Button(action: {
                resetGame?()
                dismiss()
            }) {
                Text("Quit")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
            }
        }
    }
}

struct GameEndingView_Previews: PreviewProvider {
    static var previews: some View {
        GameEndingView()
    }
}
