//
//  Darcel.swift
//  Hey Darcel
//
//  Created by Adam Johnson on 3/2/2023.
//

import SwiftUI

struct DarcelEye {
    var x: CGFloat = 0
    var y: CGFloat = 0
}

struct DarcelFace {
    var eye = DarcelEye()
    var mouth = "frown"
    var eyelid = "1"
}

struct Darcel: View {
    @State private var darcelFace = DarcelFace()
    @State private var eyeTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var mouthTimer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    @State private var eyelidTimer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
    @State private var shakeTimer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    @State private var shakeTimerCount = 0
    @State private var shakePos = ""
    let isRecording: Bool
    let questionFieldFocused: Bool
    let shaking: Bool
    let offsetX = 11.8
    let offsetY = 11.5
    let offsetXY = 14.8
    
    var listening: Bool {
        return isRecording || questionFieldFocused ? true : false
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
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
                        if !listening && !shaking {
                            darcelFace.mouth = Int.random(in: 0..<3) == 0 ? newMouth() : darcelFace.mouth /// 1/3 chance of changing
                        }
                    }
                
                // Eye
                Image("darcel-eye")
                    .resizable()
                    .scaledToFit()
                    .offset(x: darcelFace.eye.x, y: darcelFace.eye.y)
                    .animation(.linear, value: [darcelFace.eye.x, darcelFace.eye.y])
                    .onReceive(eyeTimer) { time in
                        // Eye
                        if !listening && !shaking {
                            darcelFace.eye = Int.random(in: 0..<2) == 0 ? newEyePos(height: geometry.size.height) : DarcelEye(x: darcelFace.eye.x, y: darcelFace.eye.y) /// 1/2 chance of changing
                        }
                    }
                
                // Eyelid
                Image("darcel-eyelid-\(darcelFace.eyelid)")
                    .resizable()
                    .scaledToFit()
                    .onReceive(eyelidTimer) { time in
                        // Eyelid
                        darcelFace.eyelid = Int.random(in: 0..<4) == 0 && !shaking ? "closed" : darcelFace.eyelid /// 1/4 chance of closing
                        
                        if darcelFace.eyelid == "closed" {
                            // Wait a moment
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                darcelFace.eyelid = listening || shaking ? "none" : newEyelid() /// Change if not listening
                            }
                        }
                    }
            }
            .frame(maxWidth: .infinity)
            .onChange(of: listening) { newValue in
                if newValue {
                    // Eye
                    darcelFace.eye = DarcelEye(x: 0, y: 0)
                    
                    // Mouth
                    darcelFace.mouth = "flat"
                    
                    // Eyelid
                    darcelFace.eyelid = "none"
                }
            }
            .onChange(of: shaking) { newValue in
                if newValue {
                    // Eye
                    shakePos = ""
                    shakeTimerCount = 0
                    shakeTimer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect() /// Start shake timer
                    
                    // Mouth
                    darcelFace.mouth = "frown"
                    
                    // Eyelid
                    darcelFace.eyelid = "none"
                }
            }
            .onReceive(shakeTimer) { time in
                if shaking {
                    // Shake eye
                } else {
                    shakeTimer.upstream.connect().cancel()
                }
            }
        }
    }
    
    func newEyePos(height: CGFloat) -> DarcelEye {
        let rand = Int.random(in: 0..<6)
        let xOffset = height / offsetX
        let yOffset = height / offsetY
        let xYOffset = height / offsetXY
        
        switch rand {
        case 1:
            // E
            return DarcelEye(x: xOffset, y: 0)
        case 2:
            // SE
            return DarcelEye(x: xYOffset, y: xYOffset)
        case 3:
            // S
            return DarcelEye(x: 0, y: yOffset)
        case 4:
            // SW
            return DarcelEye(x: 0 - xYOffset, y: xYOffset)
        case 5:
            // W
            return DarcelEye(x: 0 - xOffset, y: 0)
        default:
            // C
            return DarcelEye(x: 0, y: 0)
        }
    }
}

func newMouth() -> String {
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

func newEyelid() -> String {
    let rand = Int.random(in: 0..<3)
    
    switch rand {
    case 1:
        return "none"
    case 2:
        return "2"
    default:
        return "1"
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
