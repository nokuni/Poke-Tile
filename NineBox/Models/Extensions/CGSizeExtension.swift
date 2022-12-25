//
//  CGSizeExtension.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 19/02/2022.
//

import SwiftUI

extension CGSize {
    static var screen: CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    func signReduce(_ sign: (CGFloat, CGFloat) -> CGFloat, by number: CGFloat) -> CGSize {
        return CGSize(width: sign(width, number), height: sign(height, number))
    }
}
