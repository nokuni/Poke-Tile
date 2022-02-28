//
//  HomeItemView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

struct HomeItemView: View {
    var size: CGSize
    var item: HomeItem
    var body: some View {
        VStack {
            Image(item.icon)
                .resizable()
                .scaledToFit()
            Text(item.title)
                .foregroundColor(.white)
                .font(.system(size: size.width * 0.02, weight: .black, design: .rounded))
        }
        .padding(10)
        .frame(width: size.width * 0.2, height: size.width * 0.2)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.yellow, lineWidth: 5)
                .foregroundColor(.gray)
                .background(Color.black.cornerRadius(10))
                .padding(5)
        )
    }
}

struct HomeItemView_Previews: PreviewProvider {
    static var previews: some View {
        HomeItemView(size: CGSize.screen, item: HomeItem.summons)
    }
}
