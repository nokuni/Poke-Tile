//
//  Profile.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import Foundation

enum UserGenre: String {
    case boy, girl
}

struct Profile {
    var name: String = ""
    var image: String = ""
    var genre: UserGenre?
    var theme: Theme = Theme.togepi
}

extension Profile {
    static let previewExample = Profile()
}
