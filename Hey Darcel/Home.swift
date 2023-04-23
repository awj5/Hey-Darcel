//
//  Home.swift
//  Hey Darcel
//
//  Created by Adam Johnson on 22/4/2023.
//

import SwiftUI

struct Home: View {
    @State private var isRecording = false
    @State private var question = ""
    @FocusState private var questionFieldFocused: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Heading
                if !questionFieldFocused { /// Hide if keyboard open
                    Heading1(lines: ["Ask me a", "question", "then shake!"])
                        .frame(height: geometry.size.height / 4)
                }
                
                // Darcel
                Darcel(isRecording: isRecording, questionFieldFocused: questionFieldFocused)
                    .frame(height: geometry.size.height / 2)
                
                // Question input
                Question(isRecording: $isRecording, question: $question, questionFieldFocused: _questionFieldFocused)
                    .frame(height: !questionFieldFocused ? geometry.size.height / 4 : geometry.size.height / 2) /// Adjust size when keyboard open
            }
            .onShake {
                print("Device shaken!")
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .background(.gray)
    }
}
