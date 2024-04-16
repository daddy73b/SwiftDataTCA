//
//  SwiftDataTCAApp.swift
//  SwiftDataTCA
//
//  Created by 60157085 on 2024/04/04.
//

import SwiftUI
import ComposableArchitecture

@main
struct SwiftDataTCAApp: App {

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
