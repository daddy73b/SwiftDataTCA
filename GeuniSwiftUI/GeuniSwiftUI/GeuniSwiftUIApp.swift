//
//  GeuniSwiftUIApp.swift
//  GeuniSwiftUI
//
//  Created by 60157085 on 2024/02/27.
//

import SwiftUI
import ComposableArchitecture

@main
struct GeuniSwiftUIApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView(
                store: Store(
                    initialState: Feature.State(),
                    reducer: {
                        Feature()
                    }
                )
            )
        }
    }
}
