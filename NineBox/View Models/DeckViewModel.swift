//
//  DeckViewModel.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import Foundation

final class DeckViewModel: ObservableObject {
    @Published var selectedIndex: Int = 0
    @Published var selectedCard: Card? = nil
    @Published var selectedDeckIndex = 0
    @Published var isShowingNameAlert = false
    
    init() { }
}
