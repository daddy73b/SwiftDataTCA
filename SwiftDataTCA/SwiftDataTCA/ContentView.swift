//
//  ContentView.swift
//  SwiftDataTCA
//
//  Created by 60157085 on 2024/04/04.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    var body: some View {
        VStack {
            HStack {
                Button("- db") {
                }
                Button("+ db") {
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
