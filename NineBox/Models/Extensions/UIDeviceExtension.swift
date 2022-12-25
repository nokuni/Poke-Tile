//
//  UIDeviceExtension.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 25/12/22.
//

import SwiftUI

extension UIDevice {
    static var isOnPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
}
