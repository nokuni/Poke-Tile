//
//  LongButtonView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 01/03/2022.
//

import SwiftUI

struct LongButtonView: View {
    var text: String
    var textColor: Color
    var textSize: CGFloat
    var textStrokeColor: Color
    var buttonColor: Color
    var buttonStrokeColor: Color
    var body: some View {
        Text(text)
            .foregroundColor(textColor)
            .font(.system(size: CGSize.screen.height * textSize, weight: .semibold, design: .rounded))
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

struct LongButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LongButtonView(text: "", textColor: .black, textSize: 0.025, textStrokeColor: .black, buttonColor: .black, buttonStrokeColor: .black)
    }
}
