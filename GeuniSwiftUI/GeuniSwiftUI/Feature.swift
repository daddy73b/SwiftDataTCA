//
//  Feature.swift
//  GeuniSwiftUI
//
//  Created by 60157085 on 2024/02/27.
//

import Foundation
import ComposableArchitecture
import SwiftData

struct Feature: Reducer {

    struct State: Equatable {
        var count: Int = 0
        var responseValue: String = ""
        var databaseAmount: Int = DBClient.shared.fetchItems().count
    }

    enum Action: Equatable {
        case plusButtonTap
        case minusButtonTap

        case plusDBTap
        case minusDBTap
        case undoDBTap
        case redoDBTap

        case apiRequest
        case numberFactResponse(TaskResult<String>)
    }

    @Dependency(\.apiClient) var apiClient
    func reduce(
        into state: inout State,
        action: Action
    ) -> Effect<Action> {
        switch action {
        case .plusButtonTap:
            state.count += 1
            return .none
        case .minusButtonTap:
            state.count -= 1
            return .none
        case .plusDBTap:
            DBClient.shared.appendItem(item: .init(name: "TEST"))
            state.databaseAmount = DBClient.shared.fetchItems().count
            return .none
        case .minusDBTap:
            if let lastItem = DBClient.shared.fetchItems().last {
                DBClient.shared.removeItem(lastItem)
                state.databaseAmount = DBClient.shared.fetchItems().count
            } else {
                state.databaseAmount = 0
            }
            return .none
        case .undoDBTap:
            DBClient.shared.undo()
            state.databaseAmount = DBClient.shared.fetchItems().count
            return .none
        case .redoDBTap:
            DBClient.shared.redo()
            state.databaseAmount = DBClient.shared.fetchItems().count
            return .none
        case .apiRequest:
            return .run { [count = state.count] send in
                await send(
                    .numberFactResponse(
                        TaskResult { try await self.apiClient.fetchNumberInfo(count) }
                    )
                )
            }
        case .numberFactResponse(let response):
            switch response {
            case .success(let success):
                state.responseValue = success
            case .failure(let error):
                state.responseValue = error.localizedDescription
            }
            return .none
        }
    }
}

class DBThreadSafeCounter {
    private var count = DBClient.shared.fetchItems()
    private let lock = DispatchQueue(label: "counter")

    var tempItem: Item? = Item.init(name: "TEST")
    func increment() {
        lock.sync {
            if let tempItem {
                DBClient.shared.appendItem(item: tempItem)
            }
            print("Incremented: \(DBClient.shared.fetchItems())")
        }
    }

    func decrement() {
        lock.sync {
            if let tempItem {
                DBClient.shared.removeItem(tempItem)
            }
            print("Decremented: \(DBClient.shared.fetchItems())")
        }
    }

    func getCount() -> Int {
        return lock.sync {
            return DBClient.shared.fetchItems().count
        }
    }
}

class UnsafeCounter {

    func increment() {
        let tempItem = Item.init(name: "TEST")
        DBClient.shared.appendItem(item: tempItem)
    }

    func decrement() {
        DBClient.shared.removeLast()
    }

    func getCount() -> Int {
        return DBClient.shared.fetchItems().count
    }
}

class ThreadSafeCounter {
    private let queue = DispatchQueue(label: "com.example.threadsafecounter", attributes: .concurrent)

    func increment() {
        queue.sync(flags: .barrier) {
            let tempItem = Item.init(name: "TEST")
            DBClient.shared.appendItem(item: tempItem)
        }
    }

    func decrement() {
        queue.sync(flags: .barrier) {
            DBClient.shared.removeLast()
        }
    }

    func getCount() -> Int {
        var result = 0
        queue.sync {
            result = DBClient.shared.fetchItems().count
        }
        return result
    }
}
