//
//  Profile.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import Foundation

struct Profile {
    var name: String = ""
    var image: String = "invisible"
    var theme: Theme = Theme.togepi
}

extension Profile {
    static let previewExample = Profile()
}
