//
//  Shared.swift
//  Hey Darcel
//
//  Created by Adam Johnson on 7/2/2023.
//

import SwiftUI

// Heading 1

struct Heading1: View {
    let lines: [String]
    
    var body: some View {
        VStack(spacing: UIDevice.current.userInterfaceIdiom == .pad ? -40 : -26) {
            ForEach(lines, id: \.self) { line in
                Text(line)
            }
        }
        .font(.custom("ITC Avant Garde Gothic LT Bold", size: UIDevice.current.userInterfaceIdiom == .pad ? 80: 52))
        .tracking(-4)
    }
}
