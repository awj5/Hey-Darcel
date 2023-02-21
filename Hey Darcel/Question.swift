//
//  Question.swift
//  Hey Darcel
//
//  Created by Adam Johnson on 12/2/2023.
//

import SwiftUI

struct Question: View {
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @Binding var isRecording: Bool
    @Binding var question: String
    @FocusState var questionFocused: Bool
    
    var body: some View {
        ZStack {
            if (speechRecognizer.transcript != "") {
                VStack(spacing: 0) {
                    Spacer()
                    
                    // Textfield
                    TextField("", text: $question, prompt: Text("Type your question here").foregroundColor(.white), axis: .vertical)
                        .focused($questionFocused)
                        .foregroundColor(Color.white)
                        .onChange(of: question) { newValue in
                            question = String(newValue.prefix(140)) // Limit characters
                        }
                    
                    Spacer()
                    
                    // Buttons
                    if (questionFocused) {
                        QuestionButtons(question: $question, questionFocused: _questionFocused)
                    }
                }
            }
            /* if (speechRecognizer.transcript == "") {
             // Speech allowed
             Button {
             //speechRecognizer.stopTranscribing()
             speechRecognizer.reset()
             speechRecognizer.transcribe()
             isRecording = true
             } label: {
             Image(systemName: "mic")
             .font(.system(size: 72))
             }
             } else {
             VStack {
             TextField("Type your question here", text: $question, axis: .vertical)
             .focused($questionFocused)
             .font(.custom("ITC Avant Garde Gothic LT Bold", size: UIDevice.current.userInterfaceIdiom == .pad ? 48: 24))
             .foregroundColor(Color.white)
             .padding()
             
             /* if (questionFocused) {
              Button(speechRecognizer.transcript) {
              questionFocused = false
              }
              } */
             }
             } */
        }
        .padding()
    }
}

struct Question_Previews: PreviewProvider {
    static var previews: some View {
        Question(isRecording: .constant(false), question: .constant(""))
    }
}
