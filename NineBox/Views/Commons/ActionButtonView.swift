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
    var textSize: CGFloat
    var textStrokeColor: Color
    var buttonColor: Color
    var buttonStrokeColor: Color
    var body: some View {
        Text(text)
            .foregroundColor(textColor)
            .font(.system(size: CGSize.screen.height * textSize, weight: .bold, design: .rounded))
            .strokeText(color: textStrokeColor)
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(buttonColor)
                    .cornerRadius(5)
                    .strokeText(color: buttonStrokeColor)
            )
    }
}

struct ActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ActionButtonView(text: "", textColor: .steelBlue, textSize: 0.05, textStrokeColor: .steelBlue, buttonColor: .steelBlue, buttonStrokeColor: .steelBlue)
    }
}
