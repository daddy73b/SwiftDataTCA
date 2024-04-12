//
//  ContentView.swift
//  SwiftDataTCA
//
//  Created by 60157085 on 2024/04/04.
//

import SwiftUI
import SwiftData
import SwiftUI

struct ContentView: View {

    @State private var items = [String]()

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.addItem()
                }) {
                    Text("추가").foregroundColor(.black).padding()
                }
                .border(Color.black, width: 1)

                Button(action: {
                    self.removeItem()
                }) {
                    Text("삭제").foregroundColor(.black).padding()
                }
                .border(Color.black, width: 1)

            }.padding()

            List {
                ForEach(items, id: \.self) { item in
                    Text(item)
                }
            }
        }
    }

    // 데이터 추가 메소드
    func addItem() {
        let newItem = "Item \(items.count + 1)"
        items.append(newItem)
    }

    // 데이터 삭제 메소드
    func removeItem() {
        if !items.isEmpty {
            items.removeLast()
        }
    }
}


#Preview {
    ContentView()
}
