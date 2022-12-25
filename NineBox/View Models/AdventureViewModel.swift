//
//  AdventureViewModel.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 07/03/2022.
//

import SwiftUI

class AdventureViewModel: ObservableObject {
    
    @Published var isInAdventure: Bool = false
    @Published var adventures = AdventureModel.all
    @Published var lab = LabModel.all
    @Published var regions = WorldRegion.regions
    @Published var tutorialTrainers = Trainer.tutorialTrainers
    @Published var selectedTrainer: Trainer? = nil
    @Published var tutorialTrainerState: TutorialTrainerState = .inSelection
    @Published var worldTrainerState: WorldTrainerState = .inSelection
    
    init() {
        // For test
        unlockAdventure("World")
        unlockAdventure("Lab")
        unlockLab("Tutorials")
        
        loadTutorialTrainers()
        loadWorldTrainers()
        unlockFirstTrainers()
    }
    
    func loadWorldTrainers() {
        for index in regions.indices {
            let trainers = regions[index].trainerNames.map { try! Trainer.getWorldTrainer($0) }
            regions[index].trainers = trainers
        }
    }
    func loadTutorialTrainers() {
        tutorialTrainers = tutorialTrainers.filter { $0.name != "Beginning Prof.Oak" && $0.name != "Ending Prof.Oak" }
    }
    
    func unlockLab(_ title: String) {
        guard let index = lab.firstIndex(where: { $0.title == title }) else { return }
        lab[index].isUnlocked = true
    }
    func unlockAdventure(_ title: String) {
        guard let index = adventures.firstIndex(where: { $0.title == title }) else { return }
        adventures[index].isUnlocked = true
    }
    
    func toggleWorldTrainerState(on state: WorldTrainerState) {
        worldTrainerState = state
    }
    
    func unlockFirstTrainers() {
        for index in regions.indices {
            regions[index].trainers[0].isUnlocked = true
        }
        tutorialTrainers[0].isUnlocked = true
    }
    
    func worldTrainerEndBattleActions(_ trainer: Trainer?, addCards: (([Card]) -> Void)) {
        if let trainer = trainer {
            guard let adventureIndex = regions.firstIndex(where: { $0.trainers.contains(trainer) }) else { return }
            guard regions[adventureIndex].trainers.contains(where: { $0.name == trainer.name }) else { return }
            unlockNextWorldTrainer(from: trainer)
            if !trainer.hasBeenCleared {
                let reward = trainer.reward.map { try! Card.getPokemon(name: $0) }
                addCards(reward)
            }
        }
    }
    func tutorialTrainerEndBattleActions(_ trainer: Trainer?, addCards: (([Card]) -> Void)) {
        if let trainer = trainer {
            guard tutorialTrainers.contains(where: { $0.name == trainer.name }) else { return }
            unlockNextTrainingTrainer(from: trainer)
            if !trainer.hasBeenCleared {
                let reward = trainer.reward.map { try! Card.getPokemon(name: $0) }
                addCards(reward)
            }
        }
    }
    
    func unlockNextTrainingTrainer(from trainer: Trainer) {
        guard let index = tutorialTrainers.firstIndex(of: trainer) else { return }
        tutorialTrainers[index].hasBeenCleared = true
        guard (index + 1) < tutorialTrainers.count else { return }
        tutorialTrainers[index + 1].isUnlocked = true
    }
    
    func unlockNextWorldTrainer(from trainer: Trainer) {
        guard let adventureIndex = regions.firstIndex(where: { $0.trainers.contains(trainer) }) else { return }
        guard let index = regions[adventureIndex].trainers.firstIndex(of: trainer) else { return }
        regions[adventureIndex].trainers[index].hasBeenCleared = true
        guard (index + 1) < regions[adventureIndex].trainers.count else { return }
        regions[adventureIndex].trainers[index + 1].isUnlocked = true
    }
    
    func checkAdventureMissions(_ missions: inout [Mission]) {
        for adventure in regions {
            if adventure.trainers.allSatisfy({ $0.hasBeenCleared }) {
                if let index = missions.firstIndex(where: { $0.name == adventure.title }) {
                    if !missions[index].isDone {
                        missions[index].isDone = true
                    }
                }
            }
        }
    }
}
