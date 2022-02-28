//
//  AdventureBackgroundView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

struct AdventureBackgroundView: View {
    var size: CGSize
    var title: String
    var adventure: Adventure
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 0, x: 2, y: 2)
                .font(.system(size: size.width * 0.1, weight: .bold, design: .rounded))
            
            Spacer()
            
            Image(adventure.debuff.backgroundImage)
                .resizable()
                .scaledToFit()
                .frame(width: size.width * 0.2, height: size.width * 0.2)
        }
        .padding(.horizontal, 40)
        .frame(maxWidth: .infinity, maxHeight: size.height * 0.1, alignment: .leading)
    }
}

struct AdventureBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        AdventureBackgroundView(size: CGSize.screen, title: "Title", adventure: Adventure.adventures[0])
    }
}
