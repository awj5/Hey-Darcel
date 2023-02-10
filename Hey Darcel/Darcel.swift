//
//  Darcel.swift
//  Hey Darcel
//
//  Created by Adam Johnson on 3/2/2023.
//

import SwiftUI

struct Darcel: View {
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
                Image("darcel-mouth-smile")
                    .resizable()
                    .scaledToFit()
                
                // Eye
                Image("darcel-eye")
                    .resizable()
                    .scaledToFit()
                    .offset(y: geometry.size.height / 7.4)
            }
            .frame(maxWidth: .infinity)
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
