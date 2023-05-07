//
//  QuestionFieldButtons.swift
//  Hey Darcel
//
//  Created by Adam Johnson on 21/2/2023.
//

import SwiftUI

struct QuestionFieldButtons: View {
    @Binding var question: String
    @Binding var isRecording: Bool
    @FocusState var questionFieldFocused: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            // Clear
            if !isRecording {
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
                if isRecording {
                    isRecording = false; /// Stop recording
                } else {
                    questionFieldFocused = false /// Close keyboard
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

// ButtonText

struct ButtonText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("ITC Avant Garde Gothic LT Bold", size: UIDevice.current.userInterfaceIdiom == .pad ? 36: 24))
            .tracking(-1)
            .frame(maxWidth: UIDevice.current.userInterfaceIdiom == .pad ? 160 : .infinity)
            .padding(8)
            .background(
                Capsule()
                    .fill(.white)
            )
    }
}

extension View {
    func buttonText() -> some View {
        modifier(ButtonText())
    }
}

struct QuestionFieldButtons_Previews: PreviewProvider {
    static var previews: some View {
        QuestionFieldButtons(question: .constant(""), isRecording: .constant(false))
            .background(.gray)
    }
}
