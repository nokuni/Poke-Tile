//
//  ImageExtension.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 17/02/2022.
//

import SwiftUI

extension Image {
    // Zoomed center of an image
    func centerCropped(radius: CGFloat, alignment: Alignment) -> some View {
        GeometryReader { geo in
            self
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.height, alignment: alignment)
                .clipShape(RoundedRectangle(cornerRadius: radius))
                .clipped(antialiased: true)
        }
    }
}
