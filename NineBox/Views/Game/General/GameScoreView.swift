//
//  GameScoreView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

struct GameScoreView: View {
    var size: CGSize
    var points: Int
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .frame(width: size.width * 0.15, height: size.width * 0.15)
            Text("\(points)")
                .font(.system(size: size.width * 0.1, weight: .bold, design: .rounded))
        }
    }
}

struct GameScoreView_Previews: PreviewProvider {
    static var previews: some View {
        GameScoreView(size: CGSize.screen, points: 0)
    }
}
