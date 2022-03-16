//
//  MissionViewModel.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 12/03/2022.
//

import SwiftUI

class MissionViewModel: ObservableObject {
    @Published var isInMissions: Bool = false
    @Published var missions = Mission.all
    
    func completeMission(_ name: String) {
        guard let index = missions.firstIndex(where: { $0.name == name }) else { return }
        missions[index].isDone = true
    }
}
