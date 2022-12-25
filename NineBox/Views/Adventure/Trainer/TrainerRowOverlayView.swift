//
//  TrainerRowOverlayView.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 25/12/22.
//

import SwiftUI

struct TrainerRowOverlayView: View {
    var isUnlocked: Bool
    var size: CGSize
    var body: some View {
        ZStack {
            if !isUnlocked {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.black.opacity(0.5))
                Image(systemName: "lock.fill")
                    .foregroundColor(.white)
                    .font(.system(size: size.width * 0.1, weight: .bold, design: .rounded))
            }
        }
    }
}

struct TrainerRowOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerRowOverlayView(isUnlocked: true, size: CGSize.screen)
    }
}
