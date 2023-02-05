//
//  ContentView.swift
//  Hey Darcel
//
//  Created by Adam Johnson on 3/2/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Text("Hello, World!")
                    .frame(height: geometry.size.height / 3)
                
                Darcel()
                    .frame(height: geometry.size.height / 3)
                
                Text("Hello, World!")
                    .frame(height: geometry.size.height / 3)
            }
            .frame(width: geometry.size.width)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
