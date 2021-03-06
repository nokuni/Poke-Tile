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
    var theme: Theme
    var body: some View {
        VStack {
            Image(item.icon)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.steelBlue)
                .scaledToFit()
            Text(item.title)
                .foregroundColor(.white)
                .font(.system(size: size.width * 0.02, weight: .bold, design: .rounded))
                .padding(2)
                .frame(maxWidth: .infinity)
                .background(Color.steelBlue.cornerRadius(5))
        }
        .padding(10)
        .overlay(
            ZStack {
                if !item.isUnlocked {
                    Color.black
                        .opacity(0.5)
                        .cornerRadius(5)
                        .padding(5)
                    Image("lock")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: size.width * 0.05, height: size.width * 0.05)
                }
            }
        )
        .frame(width: size.width * 0.2, height: size.width * 0.2)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.steelBlue, lineWidth: 2)
                .foregroundColor(.gray)
                .background(
                    Color.white
                        .cornerRadius(5)
                )
                .padding(5)
        )
    }
}

struct HomeItemView_Previews: PreviewProvider {
    static var previews: some View {
        HomeItemView(size: CGSize.screen, item: HomeItem.cards, theme: Theme.pikachu)
    }
}
