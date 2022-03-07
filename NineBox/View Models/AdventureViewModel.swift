//
//  AdventureViewModel.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 07/03/2022.
//

import SwiftUI

class AdventureViewModel: ObservableObject {
    @Published var trainers = [Trainer]()
    @Published var selectedTrainer: Trainer? = nil
    
    func showTrainers(from adventure: Adventure) {
        trainers = adventure.realTrainers
        guard !trainers.isEmpty else { return }
        trainers[0].isUnlocked = true
    }
}
