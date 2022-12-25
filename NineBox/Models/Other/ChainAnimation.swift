//
//  ChainAnimation.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 08/12/22.
//

import Foundation

final public class ChainAnimation: ObservableObject {
    
    private var timer: Timer?
    
    public var duration: TimeInterval?
    public var startAction: (() -> Void)?
    public var whileAction: (() -> Void)?
    public var endAction: (() -> Void)?
    
    public func start(duration: TimeInterval, startAction: (() -> Void)?, whileAction: (() -> Void)?, endAction: (() -> Void)?, timeInterval: TimeInterval = 1) {
        
        self.duration = duration
        self.startAction = startAction
        self.whileAction = whileAction
        self.endAction = endAction
        
        self.startAction?()
        
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { timer in
            self.animate(timer: timer, timeInterval: timeInterval)
        }
    }
    
    public func cancelTimer() { timer?.invalidate() }
    
    private func animate(timer: Timer, timeInterval: TimeInterval = 1) {
        if let duration = self.duration {
            if duration > 0 {
                self.whileAction?()
                self.duration! -= timeInterval
            } else {
                timer.invalidate()
                self.endAction?()
            }
        }
    }
}
