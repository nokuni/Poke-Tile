//
//  ToggableClearView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 01/03/2022.
//

import SwiftUI

struct ToggableClearView: View {
    @Binding var toggable: Bool
    var body: some View {
        Color.white
            .opacity(0.01)
            .onTapGesture {
                withAnimation(.spring()) {
                    toggable = true
                }
            }
    }
}

struct ToggableClearView_Previews: PreviewProvider {
    static var previews: some View {
        ToggableClearView(toggable: .constant(false))
    }
}
