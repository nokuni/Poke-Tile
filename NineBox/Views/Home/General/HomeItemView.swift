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
            Text(item.title)
                .foregroundColor(.white)
                .font(.system(size: size.width * 0.02, weight: .bold, design: .rounded))
                .padding(2)
                .frame(maxWidth: .infinity)
                .background(Color.steelBlue.cornerRadius(5))
                .frame(width: size.width * 0.15, height: size.width * 0.15, alignment: .bottom)
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
                } else {
                    Image(item.icon)
                        .resizable()
                        //.renderingMode(.template)
                        //.foregroundColor(.steelBlue)
                        .frame(width: CGSize.screen.height * 0.07, height: CGSize.screen.height * 0.07)
                }
            }
                .frame(width: size.width * 0.2, height: size.width * 0.25, alignment: .top)
        )
        .frame(width: size.width * 0.2, height: size.width * 0.2)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.steelBlue, lineWidth: 2)
                .foregroundColor(.gray)
                .background(
                    Color(red: 240/255, green: 255/255, blue: 255/255)
                    //Color.white
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
