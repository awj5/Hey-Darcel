//
//  QuestionMic.swift
//  Hey Darcel
//
//  Created by Adam Johnson on 2/3/2023.
//

import SwiftUI

struct QuestionMic: View {
    @ObservedObject var speechRecognizer: SpeechRecognizer
    @Binding var isRecording: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            // Mic
            Button {
                speechRecognizer.reset()
                speechRecognizer.transcribe()
                isRecording = true
            } label: {
                Image(systemName: "mic")
                    .font(.system(size: 72))
            }
            
            Spacer()
            
            // Keyboard
            Button {
                speechRecognizer.transcript = "USE KEYBOARD"
            } label: {
                Image(systemName: "keyboard")
                    .font(.system(size: 24))
            }
            .accentColor(.white)
        }
    }
}

struct QuestionMic_Previews: PreviewProvider {
    static var previews: some View {
        QuestionMic(speechRecognizer: SpeechRecognizer(), isRecording: .constant(false))
    }
}
