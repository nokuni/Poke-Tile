//
//  DeckViewModel.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 05/03/2022.
//

import SwiftUI

class DeckViewModel: ObservableObject {
    @Published var selectedDeckIndex = 0
    @Published var selectedIndex = 0
}
