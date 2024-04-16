//
//  ContentView.swift
//  SwiftDataTCA
//
//  Created by 60157085 on 2024/04/04.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

struct ContentView: View {

    let store: StoreOf<Feature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                HStack {
                    Button(action: {
                        viewStore.send(.plusDBTap)
                    }) {
                        Text("추가").foregroundColor(.black).padding()
                    }
                    .border(Color.black, width: 1)

                    Button(action: {
                        viewStore.send(.minusDBTap)
                    }) {
                        Text("삭제").foregroundColor(.black).padding()
                    }
                    .border(Color.black, width: 1)

                    Button(action: {
                        viewStore.send(.redoDBTap)
                    }) {
                        Text("Redo").foregroundColor(.black).padding()
                    }
                    .border(Color.black, width: 1)

                    Button(action: {
                        viewStore.send(.undoDBTap)
                    }) {
                        Text("Undo").foregroundColor(.black).padding()
                    }
                    .border(Color.black, width: 1)

                }.padding()

                List {
                    ForEach(viewStore.items) { item in
                        Text(item.name)
                    }
                }
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
