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
                VStack(spacing: -24) {
                    Text("Ask me a")
                    Text("question")
                    Text("then shake!")
                }
                .font(.custom("ITC Avant Garde Gothic LT Bold", size: 48))
                .tracking(-4)
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
