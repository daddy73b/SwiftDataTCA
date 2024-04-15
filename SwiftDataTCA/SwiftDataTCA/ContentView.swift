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
        self.items = DBManager.shared.fetchItems()
    }

    // 데이터 추가 메소드
    func addItem() {
        let newItem = Item(index: DBManager.shared.fetchItems().count)
        DBManager.shared.appendItem(item: newItem)
        fetchItems()
    }

    // 데이터 삭제 메소드
    func removeItem() {
        if let lastItem = items.last {
            DBManager.shared.removeItem(lastItem)
            fetchItems()
        }
    }
}


#Preview {
    ContentView()
}
