//
//  ContentView.swift
//  Hey Darcel
//
//  Created by Adam Johnson on 3/2/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Home()
            
            // Info button
            Button {
                /// Show info
            } label: {
                Image(systemName: "info.circle")
                    .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 36 : 24))
            }
            .accentColor(.black)
            .padding()
        }
        .background(Color("DarcelYellow"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
