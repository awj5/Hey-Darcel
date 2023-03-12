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
    @Binding var forceKeyboard: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            // Mic
            Button {
                if isRecording {
                    // Stop recording
                    speechRecognizer.stopTranscribing()
                    isRecording = false
                } else {
                    // Start recording
                    speechRecognizer.reset()
                    speechRecognizer.transcribe()
                    isRecording = true
                }
            } label: {
                Image(systemName: "mic.fill")
                    .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 108 : 72))
            }
            .accentColor(isRecording ? Color("DarcelRed") : .black)
            
            Spacer()
            
            // Keyboard
            Button {
                forceKeyboard = true;
            } label: {
                Image(systemName: "keyboard")
                    .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 36 : 24))
            }
            .accentColor(.black)
            .disabled(isRecording)
        }
    }
}

struct QuestionMic_Previews: PreviewProvider {
    static var previews: some View {
        QuestionMic(speechRecognizer: SpeechRecognizer(), isRecording: .constant(false), forceKeyboard: .constant(false))
    }
}
