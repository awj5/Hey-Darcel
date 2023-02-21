//
//  ContentView.swift
//  Hey Darcel
//
//  Created by Adam Johnson on 3/2/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isRecording = false
    @State private var question = ""
    @FocusState private var questionFocused: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Heading
                if (!questionFocused) { // Hide if keyboard open
                    Heading1(lines: ["Ask me a", "question", "then shake!"])
                        .foregroundColor(.white)
                        .frame(height: geometry.size.height / 4)
                }
                
                // Darcel
                Darcel()
                    .frame(height: geometry.size.height / 2)
                
                // Question input
                Question(isRecording: $isRecording, question: $question, questionFocused: _questionFocused)
                    .font(.custom("ITC Avant Garde Gothic LT Bold", size: UIDevice.current.userInterfaceIdiom == .pad ? 36: 24))
                    .tracking(-1)
                    .frame(height: !questionFocused ? geometry.size.height / 4 : geometry.size.height / 2) // Adjust size when keyboard open
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
