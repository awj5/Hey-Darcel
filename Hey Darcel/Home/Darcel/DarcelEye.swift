//
//  DarcelEye.swift
//  Hey Darcel
//
//  Created by Adam Johnson on 6/5/2023.
//

import SwiftUI

struct DarcelEye: View {
    @State private var eyeTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var eyePos = "C"
    @State private var eyeMoveDuration = 0.5
    @Binding var darcelFace: Face
    let listening: Bool
    let shaking: Bool
    
    var body: some View {
        GeometryReader { geometry in
            Image("darcel-eye")
                .resizable()
                .scaledToFit()
                .offset(x: darcelFace.eye.x, y: darcelFace.eye.y)
                .animation(.easeOut(duration: eyeMoveDuration), value: [darcelFace.eye.x, darcelFace.eye.y])
                .onReceive(eyeTimer) { time in
                    if !listening && !shaking {
                        darcelFace.eye = Int.random(in: 0..<2) == 0 ? newEyePos(height: geometry.size.height) : Eye(x: darcelFace.eye.x, y: darcelFace.eye.y) /// 1/2 chance of changing
                    }
                }
                .frame(maxWidth: .infinity)
                .onChange(of: shaking) { newValue in
                    if newValue {
                        // Eye
                        eyeMoveDuration = 0
                        
                        Task {
                            await shakeEye(count: 0, height: geometry.size.height) /// Init
                        }
                        
                        // Mouth
                        darcelFace.mouth = "frown"
                        
                        // Eyelid
                        darcelFace.eyelid = "none"
                    } else {
                        eyeMoveDuration = 0.5 /// Reset
                    }
                }
        }
    }
    
    private func shakeEye(count: Double, height: CGFloat) async {
        eyeMoveDuration = count * 0.01
        darcelFace.eye = count == 25 ? Eye(x: 0, y: 0) : newEyePos(height: height, isShaking: true) /// Center on last movement
        try? await Task.sleep(until: .now + .seconds(eyeMoveDuration), clock: .continuous) /// Wait for animation to complete
        
        // Move again?
        if count < 25 {
            await shakeEye(count: count + 1, height: height)
        }
    }
    
    private func newEyePos(height: CGFloat, isShaking: Bool = false) -> Eye {
        var direction = ["E", "SE", "S", "SW", "W", "C"]
        
        if isShaking {
            switch eyePos {
            case "N":
                direction = ["SE", "S", "SW"]
            case "NE":
                direction = ["S", "SW", "W"]
            case "E":
                direction = ["SW", "W", "NW"]
            case "SE":
                direction = ["N", "W", "NW"]
            case "S":
                direction = ["N", "NE", "NW"]
            case "SW":
                direction = ["N", "NE", "E"]
            case "W":
                direction = ["NE", "E", "SE"]
            case "NW":
                direction = ["E", "SE", "S"]
            default:
                direction = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
            }
        }
        
        eyePos = direction.randomElement()!
        
        // Calculate offsets using view height
        let eyeX = height / (isShaking ? 7.8 : 11.8)
        let eyeY = height / (isShaking ? 7.5 : 11.5)
        let eyeXY = height / (isShaking ? 10.8 : 14.8)
        
        // Return new eye position
        switch eyePos {
        case "N":
            return Eye(x: 0, y: 0 - eyeY)
        case "NE":
            return Eye(x: eyeXY, y: 0 - eyeXY)
        case "E":
            return Eye(x: eyeX, y: 0)
        case "SE":
            return Eye(x: eyeXY, y: eyeXY)
        case "S":
            return Eye(x: 0, y: eyeY)
        case "SW":
            return Eye(x: 0 - eyeXY, y: eyeXY)
        case "W":
            return Eye(x: 0 - eyeX, y: 0)
        case "NW":
            return Eye(x: 0 - eyeXY, y: 0 - eyeXY)
        default:
            return Eye(x: 0, y: 0)
        }
    }
}

struct DarcelEye_Previews: PreviewProvider {
    static var previews: some View {
        DarcelEye(darcelFace: .constant(Face(eye: Eye(x: 0, y: 0))), listening: false, shaking: false)
    }
}
