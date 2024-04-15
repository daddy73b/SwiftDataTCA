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

    @Environment(\.modelContext)
    private var modelContext

    @State 
    private var items: [Item] = []

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
                ForEach(items) { item in
                    Text(item.name) // Item의 name 속성 표시
                }
            }
        }
        .onAppear {
            self.fetchItems()
        }
    }

    // 저장된 아이템
    func fetchItems() {
        do {
            self.items = try modelContext.fetch(FetchDescriptor<Item>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    // 데이터 추가 메소드
    func addItem() {
        let newItem = Item(name: "Item \(items.count + 1)")
        modelContext.insert(newItem)
        do {
            try modelContext.save()
            fetchItems() // 데이터베이스에서 아이템을 다시 가져옴
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    // 데이터 삭제 메소드
    func removeItem() {
        if let lastItem = items.last {
            modelContext.delete(lastItem)
            do {
                try modelContext.save()
                fetchItems() // 데이터베이스에서 아이템을 다시 가져옴
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}


#Preview {
    ContentView()
}
