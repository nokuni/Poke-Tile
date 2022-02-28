//
//  ApplicationViewModel.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 21/02/2022.
//

import Foundation

class ApplicationViewModel: ObservableObject {
    @Published var trainer: Trainer? = nil
    
    static var shared = ApplicationViewModel()
}
