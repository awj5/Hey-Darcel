//
//  Darcel.swift
//  Hey Darcel
//
//  Created by Adam Johnson on 3/2/2023.
//

import SwiftUI

struct Darcel: View {
    var body: some View {
        ZStack {
            Image("darcel-head")
                .resizable()
                .scaledToFit()
            
            Image("darcel-glasses")
                .resizable()
                .scaledToFit()
            
        }
    }
}

struct Darcel_Previews: PreviewProvider {
    static var previews: some View {
        Darcel()
    }
}
