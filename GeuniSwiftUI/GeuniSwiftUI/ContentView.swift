//
//  ContentView.swift
//  GeuniSwiftUI
//
//  Created by 60157085 on 2024/02/27.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {

    let store: StoreOf<Feature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                Text("\(viewStore.count)")
                    .font(.title)

                Text("\(viewStore.responseValue)")
                    .font(.title)
                Text("\(viewStore.databaseAmount)")
                    .font(.subheadline)

                HStack {
                    Button("-") {
                        viewStore.send(.minusButtonTap)
                    }
                    Button("+") {
                        viewStore.send(.plusButtonTap)
                    }
                    Button("apiReq") {
                        viewStore.send(.apiRequest)
                    }
                }
                .buttonStyle(.borderedProminent)

                HStack {
                    Button("- db") {
                        viewStore.send(.minusDBTap)
                    }
                    Button("+ db") {
                        viewStore.send(.plusDBTap)
                    }
                    Button("undo") {
                        viewStore.send(.undoDBTap)
                    }
                    Button("redo") {
                        viewStore.send(.redoDBTap)
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    ContentView(
        store: Store(
            initialState: Feature.State(),
            reducer: {
                Feature()
            }
        )
    )
}
