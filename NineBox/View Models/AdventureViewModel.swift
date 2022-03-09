//
//  AdventureViewModel.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 07/03/2022.
//

import SwiftUI

class AdventureViewModel: ObservableObject {
    @Published var adventures = Adventure.adventures
    @Published var trainers = [Trainer]()
    @Published var selectedTrainer: Trainer? = nil
    
    init() { }
    
    static let shared = AdventureViewModel()
    
//    func showTrainers(from adventure: Adventure) {
//        trainers = adventure.realTrainers
//        guard !trainers.isEmpty else { return }
//        trainers[0].isUnlocked = true
//    }
    
    func unlockNextTrainer(from trainer: Trainer) {
        guard let adventure = adventures.first(where: { $0.trainers.contains(trainer.name )}) else { return }
        guard let index = adventure.trainers.firstIndex(of: trainer.name) else { return }
        guard (index + 1) < adventure.trainers.count else { return }
        //trainers[index].hasBeenCleared = true
        //trainers[index + 1].isUnlocked = true
    }
}
