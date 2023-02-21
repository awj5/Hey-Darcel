//
//  Shared.swift
//  Hey Darcel
//
//  Created by Adam Johnson on 7/2/2023.
//

import SwiftUI

// Heading1

struct Heading1: View {
    let lines: [String]
    
    var body: some View {
        VStack(spacing: UIDevice.current.userInterfaceIdiom == .pad ? -36 : -24) {
            ForEach(lines, id: \.self) { line in
                Text(line)
            }
        }
        .font(.custom("ITC Avant Garde Gothic LT Bold", size: UIDevice.current.userInterfaceIdiom == .pad ? 72: 48))
        .tracking(-4)
    }
}

// ButtonText

struct ButtonText: ViewModifier {
    func body(content: Content) -> some View {
        content
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
