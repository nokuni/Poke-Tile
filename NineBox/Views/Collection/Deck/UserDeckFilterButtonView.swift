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
            LongButtonView(text: filter.rawValue.capitalized, textColor: .white, textSize: 0.04, backgroundColor: selectedFilter == filter ? .steelBlue : .gray, borderColor: .black)
        }
    }
}

struct UserDeckFilterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        UserDeckFilterButtonView(filter: .all, selectedFilter: .constant(.all))
    }
}
