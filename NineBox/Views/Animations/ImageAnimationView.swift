//
//  ImageAnimationView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 01/03/2022.
//

import SwiftUI

struct ImageAnimationView: View {
    var background: String
    var image: String
    var size: CGSize
    var insertionEdge: Edge
    var removalEdge: Edge
    var body: some View {
        ZStack {
            Image(background)
                .resizable()
            Image(image)
                .resizable()
                .scaledToFit()
                .scaleEffect(0.9)
                .frame(width: size.width, height: size.height * 0.5)
        }
        .transition(AnyTransition.asymmetric(insertion: .move(edge: insertionEdge), removal: .move(edge: removalEdge)))
        .ignoresSafeArea()
    }
}

struct ImageAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        ImageAnimationView(background: "volcano.background", image: "blaine", size: CGSize.screen, insertionEdge: .leading, removalEdge: .trailing)
    }
}
