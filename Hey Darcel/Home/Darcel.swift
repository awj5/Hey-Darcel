//
//  Darcel.swift
//  Hey Darcel
//
//  Created by Adam Johnson on 3/2/2023.
//

import SwiftUI

struct Eye {
    var x: CGFloat = 0
    var y: CGFloat = 0
}

struct Face {
    var eye = Eye()
    var mouth = "frown"
    var eyelid = "small"
}

struct Darcel: View {
    @State private var darcelFace = Face()
    @State private var mouthTimer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    @State private var eyelidTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var listen = false
    @State var listenTask: Task<Void, Never>? = nil
    let isRecording: Bool
    let questionFieldFocused: Bool
    let shaking: Bool
    
    var inputting: Bool {
        return isRecording || questionFieldFocused ? true : false
    }
    
    var body: some View {
        ZStack {
            // Eye background
            Image("darcel-eye-bg")
                .resizable()
                .scaledToFit()
            
            // Eye
            DarcelEye(darcelFace: $darcelFace, listen: listen, shaking: shaking)
            
            // Eyelid
            Image("darcel-eyelid-\(darcelFace.eyelid)")
                .resizable()
                .scaledToFit()
                .onReceive(eyelidTimer) { time in
                    // Eyelid
                    if !shaking {
                        darcelFace.eyelid = Int.random(in: 0..<3) == 0 ? "closed" : darcelFace.eyelid /// 1/3 chance of closing
                        
                        if darcelFace.eyelid == "closed" {
                            Task {
                                try await Task.sleep(until: .now + .seconds(0.25), clock: .continuous) /// Pause a moment
                                darcelFace.eyelid = listen || shaking ? "none" : newEyelid() /// Change if not listening or shaking
                            }
                        }
                    }
                }
            
            // Head
            Image("darcel-head")
                .resizable()
                .scaledToFit()
            
            // Glasses
            Image("darcel-glasses")
                .resizable()
                .scaledToFit()
            
            // Mouth
            Image("darcel-mouth-\(darcelFace.mouth)")
                .resizable()
                .scaledToFit()
                .onReceive(mouthTimer) { time in
                    // Mouth
                    if !listen && !shaking {
                        darcelFace.mouth = Int.random(in: 0..<3) == 0 ? newMouth() : darcelFace.mouth /// 1/3 chance of changing
                    }
                }
        }
        .onChange(of: inputting) { newValue in
            if newValue {
                listen = true
                
                // Eye
                darcelFace.eye = Eye(x: 0, y: 0)
                
                // Mouth
                darcelFace.mouth = "flat"
                
                // Eyelid
                darcelFace.eyelid = "none"
                
                // Reset after 5 secs
                listenTask = Task {
                    do {
                        try await Task.sleep(until: .now + .seconds(5), clock: .continuous)
                        listen = false
                    } catch { /// Needed to catch CancellationError()
                        print(error)
                    }
                }
            } else {
                listen = false
                listenTask?.cancel()
            }
        }
    }
}

private func newMouth() -> String {
    let rand = Int.random(in: 0..<3)
    
    switch rand {
    case 1:
        return "smile"
    case 2:
        return "flat"
    default:
        return "frown"
    }
}

private func newEyelid() -> String {
    let rand = Int.random(in: 0..<4)
    
    switch rand {
    case 1:
        return "none"
    case 2:
        return "large"
    case 3:
        return "medium"
    default:
        return "small"
    }
}

struct Darcel_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            Darcel(isRecording: false, questionFieldFocused: false, shaking: false)
                .frame(height: geometry.size.height / 2)
        }
    }
}
