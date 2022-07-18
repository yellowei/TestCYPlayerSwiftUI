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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .padding(.all)
    }
}

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            VCView()
                .padding(.all)
                .border(.green)
        }
        .padding(.all)
    }
}
