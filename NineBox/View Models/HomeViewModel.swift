//
//  TutorialViewModel.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 14/03/22.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var isShowingStartingTutorial: Bool = true
    @Published var isShowingEndingTutorial: Bool = true
    @Published var homeItems = HomeItem.all
    
    init() {
        unlock("Adventures")
    }
    
    func unlock(_ title: String) {
        let index = homeItems.firstIndex(where: { $0.title == title })!
        homeItems[index].isUnlocked = true
    }
}
