//
//  ThemeModalView.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 25/12/22.
//

import SwiftUI

struct ThemeModalView: View {
    @Binding var isShowingModalTheme: Bool
    @Binding var theme: Theme
    var body: some View {
        ZStack {
            Color.black.opacity(0.7).ignoresSafeArea()
            GeometryReader { geo in
                VStack {
                    HStack {
                        Button(action: {
                            isShowingModalTheme.toggle()
                        }) {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.steelBlue, lineWidth: 3)
                                .frame(width: geo.size.width * 0.1, height: geo.size.width * 0.1)
                                .background(Color.white.cornerRadius(5))
                                .overlay(
                                    Image(systemName: "multiply")
                                        .font(.system(size: geo.size.width * 0.1, weight: .regular, design: .rounded))
                                )
                                .padding(.trailing)
                                .frame(width: geo.size.width, alignment: .trailing)
                        }
                    }
                    ScrollView(showsIndicators: false) {
                        VStack {
                            ForEach(Theme.all) { theme in
                                Button(action: {
                                    self.theme = theme
                                }) {
                                    Image(theme.image)
                                        .resizable()
                                        .centerCropped(radius: 0, alignment: .center)
                                        .frame(width: geo.size.width, height: geo.size.height * 0.25)
                                }
                            }
                        }
                    }
                    .frame(width: geo.size.width, height: geo.size.height * 0.4)
                    Text("Choose a wallpaper")
                        .foregroundColor(.white)
                        .font(.system(size: geo.size.width * 0.08, weight: .bold, design: .rounded))
                }
            }
        }
    }
}

struct ThemeModalView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeModalView(isShowingModalTheme: .constant(false), theme: .constant(.dragonite))
    }
}
