//
//  QuestionField.swift
//  Hey Darcel
//
//  Created by Adam Johnson on 1/3/2023.
//

import SwiftUI

struct QuestionField: View {
    @ObservedObject var speechRecognizer: SpeechRecognizer
    @Binding var question: String
    @Binding var isRecording: Bool
    @FocusState var questionFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            // Textfield
            TextField("", text: $question, prompt: Text(!isRecording ? "Type your question here" : "").foregroundColor(.white), axis: .vertical)
                .focused($questionFocused)
                .disabled(isRecording)
                .foregroundColor(Color.white)
                .onChange(of: question) { newValue in
                    question = String(newValue.prefix(140)) // Limit characters
                    //print("question")
                }
                .onChange(of: speechRecognizer.transcript) { newValue in
                    question = speechRecognizer.transcript
                    //print("transcript")
                }
            
            Spacer()
            
            if (questionFocused || isRecording) {
                // Buttons
                QuestionFieldButtons(speechRecognizer: speechRecognizer, question: $question, isRecording: $isRecording, questionFocused: _questionFocused)
            } else {
                // Mic
                if (speechRecognizer.transcript.contains("<<")) {
                    Text("No mic")
                } else {
                    Button {
                        speechRecognizer.transcript = ""
                    } label: {
                        Image(systemName: "mic")
                            .font(.system(size: 24))
                    }
                    .accentColor(.white)
                }
            }
        }
    }
}

struct QuestionField_Previews: PreviewProvider {
    static var previews: some View {
        QuestionField(speechRecognizer: SpeechRecognizer(), question: .constant(""), isRecording: .constant(false))
    }
}
