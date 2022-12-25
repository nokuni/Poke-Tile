//
//  ImageCroppedView.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 25/12/22.
//

import SwiftUI

struct ImageCroppedView: View {
    var image: String
    var body: some View {
        Image(image)
            .resizable()
            .centerCropped(radius: 5, alignment: .center)
    }
}

struct ImageCroppedView_Previews: PreviewProvider {
    static var previews: some View {
        ImageCroppedView(image: "")
    }
}
