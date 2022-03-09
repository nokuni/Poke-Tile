//
//  AdventureViewModel.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 07/03/2022.
//

import SwiftUI

class AdventureViewModel: ObservableObject {
    @Published var adventures = Adventure.adventures
    @Published var selectedTrainer: Trainer? = nil
    
    init() {
        loadTrainers()
        unlockFirstTrainers()
    }
    
    static let shared = AdventureViewModel()
    
    func loadTrainers() {
        for index in adventures.indices {
            let trainers = adventures[index].trainerNames.map { try! Trainer.getTrainer($0) }
            adventures[index].trainers = trainers
        }
    }
    
    func unlockFirstTrainers() {
        for index in adventures.indices {
            adventures[index].trainers[0].isUnlocked = true
        }
    }
    
    func unlockNextTrainer(from trainer: Trainer) {
        guard let adventureIndex = adventures.firstIndex(where: { $0.trainers.contains(trainer) }) else { return }
        guard let index = adventures[adventureIndex].trainers.firstIndex(of: trainer) else { return }
        guard (index + 1) < adventures[adventureIndex].trainers.count else { return }
        adventures[adventureIndex].trainers[index].hasBeenCleared = true
        adventures[adventureIndex].trainers[index + 1].isUnlocked = true
    }
}
