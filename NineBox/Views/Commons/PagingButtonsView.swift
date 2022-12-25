//
//  PagingButtonsView.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 25/12/22.
//

import SwiftUI

struct PagingButtonsView<C: Collection>: View {
    
    private let animation = ChainAnimation()
    var collection: C
    @Binding var canPressButton: Bool
    @Binding var index: Int
    
    init(collection: C, canPressButton: Binding<Bool>, index: Binding<Int>) {
        self.collection = collection
        self._canPressButton = canPressButton
        self._index = index
    }
    
    var body: some View {
        HStack {
            Button(action: {
                if canPressButton {
                    canPressButton = false
                    animation.start(
                        duration: 0.25,
                        startAction: {
                            withAnimation {
                                if index > 0 {
                                    index -= 1
                                }
                            }
                        },
                        whileAction: nil,
                        endAction: {
                            canPressButton = true
                        },
                        timeInterval: 0.25)
                }
            }) {
                ActionButtonView(text: "PREVIOUS", textColor: .white, textSize: 0.025, textStrokeColor: index > 0 ? .steelBlue : .dimgray, buttonColor: index > 0 ? .mediumBlueApp : .gray, buttonStrokeColor: index > 0 ? .steelBlue : .dimgray)
            }
            .padding(.trailing)
            
            
            Button(action: {
                if canPressButton {
                    canPressButton = false
                    animation.start(
                        duration: 0.25,
                        startAction: {
                            withAnimation {
                                if index < (collection.count - 1) {
                                    index += 1
                                }
                            }
                        },
                        whileAction: nil,
                        endAction: {
                            canPressButton = true
                        },
                        timeInterval: 0.25)
                }
            }) {
                ActionButtonView(text: "NEXT", textColor: .white, textSize: 0.025, textStrokeColor: index < (collection.count - 1) ? .steelBlue : .dimgray, buttonColor: index < (collection.count - 1) ? .mediumBlueApp : .gray, buttonStrokeColor: index < (collection.count - 1) ? .steelBlue : .dimgray)
            }
            .padding(.leading)
        }
    }
}

struct PagingButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        PagingButtonsView(collection: [], canPressButton: .constant(true), index: .constant(0))
    }
}
