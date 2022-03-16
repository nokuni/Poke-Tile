//
//  ImagesGenreChoiceView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 15/03/2022.
//

import SwiftUI

struct ImagesGenreChoiceView: View {
    var images: [String]?
    var size: CGSize
    @Binding var selectedGenreIndex: Int
    var body: some View {
        if let images = images {
            HStack {
                ForEach(images.indices, id: \.self) { index in
                    VStack {
                        if images != ["boy", "girl"] {
                            Image(images[index])
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(5)
                        } else {
                            PointingArrowView(color: .white, size: size)
                                .opacity(selectedGenreIndex == index ? 1 : 0)
                            Button(action: {
                                selectedGenreIndex = index
                            }) {
                                Image(images[index])
                                    .resizable()
                                    .centerCropped(radius: 5, alignment: .top)
                                    .shadow(color: selectedGenreIndex == index ? .white : .clear, radius: 5)
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                }
            }
        }
    }
}

struct ImagesGenreChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        ImagesGenreChoiceView(size: CGSize.screen, selectedGenreIndex: .constant(0))
    }
}
