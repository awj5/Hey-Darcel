//
//  QuestionButtons.swift
//  Hey Darcel
//
//  Created by Adam Johnson on 21/2/2023.
//

import SwiftUI

struct QuestionButtons: View {
    @Binding var question: String
    @FocusState var questionFocused: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            // Clear
            Button {
                question = ""
            } label: {
                Text("Clear")
                    .buttonText()
            }
            .accentColor(.black)
            .padding(.trailing, 8)
            .disabled(question == "")
            
            // Done
            Button {
                questionFocused = false
            } label: {
                Text("Done")
                    .buttonText()
            }
            .accentColor(.black)
            .padding(.leading, 8)
            
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.top)
    }
}

struct QuestionButtons_Previews: PreviewProvider {
    static var previews: some View {
        QuestionButtons(question: .constant(""))
    }
}
