//
//  UserDeckFilterButtonView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 05/03/2022.
//

import SwiftUI

struct UserDeckFilterButtonView: View {
    var filter: DeckFilters
    @Binding var selectedFilter: DeckFilters
    var body: some View {
        Button(action: {
            selectedFilter = filter
        }) {
            ActionButtonView(text: filter.rawValue.uppercased(), textColor: .white, textSize: 0.025, textStrokeColor: .brownApp, buttonColor: selectedFilter == filter ? .orangeApp : .gray, buttonStrokeColor: .steelBlue)
        }
    }
}

struct UserDeckFilterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        UserDeckFilterButtonView(filter: .all, selectedFilter: .constant(.all))
    }
}
