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
    @Binding var showField: Bool
    @FocusState var questionFieldFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            // Textfield
            TextField("", text: $question, prompt: Text(!isRecording ? "Type your question here" : "").foregroundColor(.white), axis: .vertical)
                .font(.custom("ITC Avant Garde Gothic LT Bold", size: UIDevice.current.userInterfaceIdiom == .pad ? 36: 24))
                .tracking(-1)
                .focused($questionFieldFocused)
                .disabled(isRecording)
                .foregroundColor(Color.white)
            
            Spacer()
            
            if questionFieldFocused || isRecording {
                // Buttons
                QuestionFieldButtons(question: $question, isRecording: $isRecording, questionFieldFocused: _questionFieldFocused)
            } else if question == "" {
                if speechRecognizer.transcript.contains("<<") {
                    // Speech not allowed
                    Link("Allow Microphone and Speech Recognition in Settings to speak to Darcel", destination: URL(string: UIApplication.openSettingsURLString)!)
                        .multilineTextAlignment(.center)
                        .font(.custom("ITC Avant Garde Gothic LT Bold", size: UIDevice.current.userInterfaceIdiom == .pad ? 18: 12))
                        .tracking(-0.5)
                        .accentColor(.black)
                        .padding([.leading, .trailing], 16)
                } else {
                    // Mic
                    Button {
                        showField = false
                    } label: {
                        Image(systemName: "mic.fill")
                            .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 48 : 32))
                    }
                    .accentColor(.black)
                }
            }
        }
    }
}

struct QuestionField_Previews: PreviewProvider {
    static var previews: some View {
        QuestionField(speechRecognizer: SpeechRecognizer(), question: .constant(""), isRecording: .constant(false), showField: .constant(false))
            .background(.gray)
    }
}
