//
//  PlayerPointsView.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 25/12/22.
//

import SwiftUI

struct PlayerPointsView: View {
    var size: CGSize
    var points: Int
    var isUser: Bool
    var body: some View {
        ZStack {
            Text("\(points)")
                .foregroundColor(.white)
                .font(.system(size: size.width * 0.1, weight: .semibold, design: .rounded))
                .shadow(color: isUser ? .blue : .red, radius: 0, x: 4, y: 4)
        }
    }
}

struct PlayerPointsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerPointsView(size: CGSize.screen, points: 0, isUser: false)
    }
}
