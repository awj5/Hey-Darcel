//
//  QuestionFieldButtons.swift
//  Hey Darcel
//
//  Created by Adam Johnson on 21/2/2023.
//

import SwiftUI

struct QuestionFieldButtons: View {
    @ObservedObject var speechRecognizer: SpeechRecognizer
    @Binding var question: String
    @Binding var isRecording: Bool
    @FocusState var questionFocused: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            // Clear
            if (!isRecording) {
                Button {
                    question = ""
                } label: {
                    Text("Clear")
                        .buttonText()
                }
                .accentColor(.black)
                .padding(.trailing, 8)
                .disabled(question == "")
            }
            
            // Done
            Button {
                if (isRecording) {
                    // Stop recording
                    speechRecognizer.stopTranscribing()
                    isRecording = false;
                } else {
                    questionFocused = false // Close keyboard
                }
            } label: {
                Text("Done")
                    .buttonText()
            }
            .accentColor(.black)
            .padding(.leading, isRecording ? 0 : 8)
            
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.top)
    }
}

struct QuestionFieldButtons_Previews: PreviewProvider {
    static var previews: some View {
        QuestionFieldButtons(speechRecognizer: SpeechRecognizer(), question: .constant(""), isRecording: .constant(false))
    }
}
