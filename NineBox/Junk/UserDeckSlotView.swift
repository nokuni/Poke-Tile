//
//  UserDeckSlotView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

//import SwiftUI
//
//struct UserDeckSlotView: View {
//    @Binding var selectedIndex: Int
//    var card: Card
//    var index: Int
//    var size: CGSize
//    var body: some View {
//        Button(action: {
//            selectedIndex = index
//        }) {
//            CardView(card: card, size: size, amount: 4)
//                .overlay(
//                    ZStack {
//                        if selectedIndex == index {
//                            Color.blue
//                                .cornerRadius(5)
//                                .opacity(0.5)
//                        }
//                    }
//                )
//        }
//    }
//}
//
//struct UserDeckSlotView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserDeckSlotView(selectedIndex: .constant(0), card: Card.empty, index: 0, size: CGSize.screen)
//    }
//}
