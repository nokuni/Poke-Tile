//
//  Stats.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import Foundation

struct Stats: Codable, Equatable, Hashable {
    var top: Int
    var trailing: Int
    var bottom: Int
    var leading: Int
}
