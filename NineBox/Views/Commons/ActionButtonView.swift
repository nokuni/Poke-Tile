//
//  StartBattleButtonView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 05/03/2022.
//

import SwiftUI

struct ActionButtonView: View {
    var text: String
    var textColor: Color
    var color: Color
    var size: CGSize
    var body: some View {
            Text(text)
                .foregroundColor(textColor)
                .font(.system(size: size.width * 0.05, weight: .bold, design: .rounded))
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(color)
                        .cornerRadius(5)
                        .shadow(color: .black, radius: 0, x: 3, y: 3)
                )
    }
}

struct ActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ActionButtonView(text: "START BATTLE", textColor: .white, color: .crimson, size: CGSize.screen)
    }
}
