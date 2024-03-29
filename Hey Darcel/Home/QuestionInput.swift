//
//  QuestionInput.swift
//  Hey Darcel
//
//  Created by Adam Johnson on 12/2/2023.
//

import SwiftUI

struct QuestionInput: View {
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @State private var showField = false
    @State private var speechTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var speechTimerCount = 0
    @Binding var isRecording: Bool
    @Binding var question: String
    @FocusState var questionFieldFocused: Bool
    let shaking: Bool
    
    var body: some View {
        ZStack {
            if showField || speechRecognizer.transcript.contains("<<") { /// Always show if speech not allowed
                // Field
                QuestionField(speechRecognizer: speechRecognizer, question: $question, isRecording: $isRecording, showField: $showField, questionFieldFocused: _questionFieldFocused, shaking: shaking)
            } else {
                // Mic
                QuestionMic(isRecording: $isRecording, showField: $showField)
            }
        }
        .padding()
        .onChange(of: isRecording) { newValue in
            if newValue == true {
                // Start recording
                speechRecognizer.reset()
                speechRecognizer.transcribe()
                speechTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() /// Start speech timer
            } else {
                // Stop recording
                speechTimer.upstream.connect().cancel() /// Stop speech timer
                speechRecognizer.stopTranscribing()
                speechTimerCount = 0 /// Reset
            }
        }
        .onChange(of: speechRecognizer.transcript) { newValue in
            if isRecording {
                question = speechRecognizer.transcript /// Update question with recorded speech
                showField = true
                speechTimerCount = 0 /// Reset
            }
        }
        .onChange(of: question) { newValue in
            question = String(newValue.prefix(140)) /// Limit characters
        }
        .onReceive(speechTimer) { time in
            if isRecording {
                if speechTimerCount == 10 {
                    isRecording = false /// No transcription for 10 secs
                } else {
                    speechTimerCount += 1 /// Count secs since last transcription
                }
            } else {
                speechTimer.upstream.connect().cancel() /// Init cancel
            }
        }
    }
}

struct Question_Previews: PreviewProvider {
    static var previews: some View {
        QuestionInput(isRecording: .constant(false), question: .constant(""), shaking: false)
            .background(.gray)
    }
}
