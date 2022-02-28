//
//  TestView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

struct TestView: View {
    @State var pageIndex = 0
    
    var body: some View {
        VStack {
            Text("current page = \(pageIndex) ")
            TabView(selection: $pageIndex) {
                Text("First").tag(0)
                Text("Second").tag(1)
                Text("Third").tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
