//
//  Darcel.swift
//  Hey Darcel
//
//  Created by Adam Johnson on 3/2/2023.
//

import SwiftUI

struct Darcel: View {
    @State private var eyeXPos: CGFloat = 0
    @State private var eyeYPos: CGFloat = 0
    @State private var mouthPos = "frown"
    @State private var expressionTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
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
                Image("darcel-mouth-\(mouthPos)")
                    .resizable()
                    .scaledToFit()
                
                // Eye
                Image("darcel-eye")
                    .resizable()
                    .scaledToFit()
                    .offset(x: eyeXPos, y: eyeYPos)
                
                // Eyelid
                Image("darcel-eyelid-1")
                    .resizable()
                    .scaledToFit()
            }
            .frame(maxWidth: .infinity)
            .onReceive(expressionTimer) { time in
                //darcelTimer.upstream.connect().cancel()
                // Eye
                let randomEyePos = Int.random(in: 0..<6)
                let eyeXOffset = 11.8
                let eyeYOffset = 11.5
                let eyeXYOffset = 14.8
                
                withAnimation(.linear(duration: 0.25)) {
                    switch randomEyePos {
                    case 1:
                        eyeXPos = geometry.size.width / eyeXOffset
                        eyeYPos = 0
                    case 2:
                        eyeXPos = geometry.size.width / eyeXYOffset
                        eyeYPos = geometry.size.height / eyeXYOffset
                    case 3:
                        eyeXPos = 0
                        eyeYPos = geometry.size.height / eyeYOffset
                    case 4:
                        eyeXPos = 0 - (geometry.size.width / eyeXYOffset)
                        eyeYPos = geometry.size.height / eyeXYOffset
                    case 5:
                        eyeXPos = 0 - (geometry.size.width / eyeXOffset)
                        eyeYPos = 0
                    default:
                        eyeXPos = 0
                        eyeYPos = 0
                    }
                    
                    // Mouth
                    let randomMouthPos = Int.random(in: 0..<3)
                    
                    switch randomMouthPos {
                    case 1:
                        mouthPos = "smile"
                    case 2:
                        mouthPos = "flat"
                    default:
                        mouthPos = "frown"
                    }
                }
            }
        }
    }
}

struct Darcel_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            Darcel()
                .frame(height: geometry.size.height / 2)
        }
    }
}
