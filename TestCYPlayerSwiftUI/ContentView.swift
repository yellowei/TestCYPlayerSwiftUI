//
//  ContentView.swift
//  TestCYPlayerSwiftUI
//
//  Created by yellowei on 2022/7/18.
//

import SwiftUI

//
//struct ContentView: View {
//    var body: some View {
//        Text("Hello, world!")
//            .padding()
//    }
//
//}


import SwiftUI

struct ContentView: View {
        var body: some View {
            VCView()
        }
//    @State var isLand = false
//
//    let orientationPublisher = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
//
//    var body: some View {
//        Text(isLand ? "我现在是横屏" : "我现在是竖屏")
//            .onReceive(orientationPublisher) { _ in
//                let windowScene = UIApplication.shared.windows.first? .windowScene
//                self.isLand = windowScene?.interfaceOrientation.isLandscape ?? false
//            }
//    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}

struct ContentView_PreviewsInLandscape: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(PreviewLayout.fixed(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width))
    }
}
