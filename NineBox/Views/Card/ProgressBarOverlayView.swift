//
//  ProgressBarOverlayView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 06/03/2022.
//

//import SwiftUI
//
//struct ProgressBarOverlayView: View {
//    var progressValue: Double
//    var body: some View {
//        ProgressBar(value: progressValue)
//    }
//}
//
//struct ProgressBarOverlayView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProgressBarOverlayView(progressValue: 0.5)
//    }
//}
//
//struct ProgressBar: View {
//    var value: Double
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack(alignment: .leading) {
//                Rectangle()
//                    .frame(width: geometry.size.width , height: geometry.size.height)
//                    .opacity(0.8)
//                    .foregroundColor(Color.gray)
//
//                Rectangle()
//                    .frame(width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width), height: geometry.size.height)
//                    .foregroundColor(Color.yellow)
//
//                Text("\((value * 100).stringWithoutZeroFraction) / 100")
//                    .foregroundColor(.white)
//                    .font(.system(size: geometry.size.width * 0.1, weight: .bold, design: .rounded))
//                    .frame(width: geometry.size.width , height: geometry.size.height)
//            }
//            .cornerRadius(45.0)
//        }
//    }
//}
//
//extension Double {
//    var stringWithoutZeroFraction: String {
//        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
//    }
//}
