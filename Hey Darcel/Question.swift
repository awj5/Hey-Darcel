//
//  Question.swift
//  Hey Darcel
//
//  Created by Adam Johnson on 12/2/2023.
//

import SwiftUI

struct Question: View {
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @State private var forceKeyboard = false
    @Binding var isRecording: Bool
    @Binding var question: String
    @FocusState var questionFocused: Bool
    
    var body: some View {
        ZStack {
            if (forceKeyboard || speechRecognizer.transcript != "") {
                // Field
                QuestionField(speechRecognizer: speechRecognizer, question: $question, isRecording: $isRecording, forceKeyboard: $forceKeyboard, questionFocused: _questionFocused)
            } else {
                // Mic
                QuestionMic(speechRecognizer: speechRecognizer, isRecording: $isRecording, forceKeyboard: $forceKeyboard)
            }
        }
        .padding()
        .font(.custom("ITC Avant Garde Gothic LT Bold", size: UIDevice.current.userInterfaceIdiom == .pad ? 36: 24))
        .tracking(-1)
        .onChange(of: question) { newValue in
            question = String(newValue.prefix(140)) // Limit characters
        }
        .onChange(of: speechRecognizer.transcript) { newValue in
            question = speechRecognizer.transcript.contains("<<") ? "" : speechRecognizer.transcript // Update question with recorded speech if allowed
        }
    }
}

struct Question_Previews: PreviewProvider {
    static var previews: some View {
        Question(isRecording: .constant(false), question: .constant(""))
    }
}
