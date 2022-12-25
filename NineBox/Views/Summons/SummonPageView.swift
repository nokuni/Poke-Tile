//
//  SummonPageView.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 25/12/22.
//

import SwiftUI

struct SummonPageView: View {
    var color: Color
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .foregroundColor(color)
    }
}

struct SummonPageView_Previews: PreviewProvider {
    static var previews: some View {
        SummonPageView(color: .black)
    }
}
