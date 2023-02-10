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
                // Heading
                Heading1(lines: ["Ask me a", "question", "then shake!"])
                    .foregroundColor(.white)
                    .frame(height: geometry.size.height / 4)
                
                // Darcel
                Darcel()
                    .frame(height: geometry.size.height / 2)
                
                // Question input
                Image(systemName: "mic")
                    .font(.system(size: 72))
                    .frame(height: geometry.size.height / 4)
            }
            .background(Color("DarcelYellow"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
