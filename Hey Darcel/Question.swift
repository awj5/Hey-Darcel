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
                // Field
                QuestionField(speechRecognizer: speechRecognizer, question: $question, isRecording: $isRecording, questionFocused: _questionFocused)
            } else {
                // Mic
                QuestionMic(speechRecognizer: speechRecognizer, isRecording: $isRecording)
            }
        }
        .padding()
        .font(.custom("ITC Avant Garde Gothic LT Bold", size: UIDevice.current.userInterfaceIdiom == .pad ? 36: 24))
        .tracking(-1)
    }
}

struct Question_Previews: PreviewProvider {
    static var previews: some View {
        Question(isRecording: .constant(false), question: .constant(""))
    }
}
