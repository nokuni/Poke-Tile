//
//  PointingArrowView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 03/03/2022.
//

import SwiftUI

struct PointingArrowView: View {
    @State private var isAnimating = false
    var color: Color
    var size: CGSize
    var body: some View {
        Image("chevron.down")
            .resizable()
            .renderingMode(.template)
            .foregroundColor(color)
            .frame(width: size.width * 0.05, height: size.width * 0.05)
            .shadow(color: .white, radius: 2)
            .offset(x: 0, y: isAnimating ? 10 : 0)
            .onAppear {
                DispatchQueue.main.async {
                    withAnimation(.linear(duration: 0.5).repeatForever(autoreverses: true)) {
                        isAnimating = true
                    }
                }
            }
    }
}

struct PointingArrowView_Previews: PreviewProvider {
    static var previews: some View {
        PointingArrowView(color: .white, size: CGSize.screen)
    }
}
