//
//  QuestionMic.swift
//  Hey Darcel
//
//  Created by Adam Johnson on 2/3/2023.
//

import SwiftUI

struct QuestionMic: View {
    @Binding var isRecording: Bool
    @Binding var showField: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            // Mic
            Button {
                isRecording.toggle()
            } label: {
                Image(systemName: "mic.fill")
                    .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 108 : 72))
            }
            .accentColor(isRecording ? Color("DarcelRed") : .black)
            
            Spacer()
            
            // Keyboard
            Button {
                showField = true;
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
        QuestionMic(isRecording: .constant(false), showField: .constant(false))
    }
}
