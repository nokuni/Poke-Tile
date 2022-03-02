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
    var backgroundColor: Color
    var borderColor: Color
    var body: some View {
        Text(text)
            .foregroundColor(textColor)
            .font(.system(size: CGSize.screen.width * 0.05, weight: .semibold, design: .rounded))
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(borderColor, lineWidth: 2)
                    .background(backgroundColor)
            )
    }
}

struct LongButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LongButtonView(text: "SURRENDER", textColor: .white, backgroundColor: .steelBlue, borderColor: .black)
    }
}