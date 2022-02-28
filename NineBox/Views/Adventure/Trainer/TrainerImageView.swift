//
//  TrainerBackgroundView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 21/02/2022.
//

import SwiftUI

struct TrainerImageView: View {
    var size: CGSize
    var height: CGFloat
    var image: String
    var body: some View {
        Image(image)
            .resizable()
            .centerCropped(radius: 0, alignment: .top)
            .frame(width: size.width * 0.4, height: size.height * height, alignment: .leading)
            .frame(width: size.width, height: size.height * 0.18, alignment: .leading)
    }
}

struct TrainerImageView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerImageView(size: CGSize.screen, height: 0.18, image: "erika")
    }
}
