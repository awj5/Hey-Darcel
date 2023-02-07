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
                Heading1(lines: ["Ask me a", "question", "then shake!"])
                    .foregroundColor(.white)
                    .frame(height: geometry.size.height / 4)
                
                Darcel()
                    .frame(height: geometry.size.height / 2)
                
                Text("Hello, World!")
                    .frame(height: geometry.size.height / 4)
            }
            .frame(width: geometry.size.width)
            .background(Color("DarcelYellow"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
