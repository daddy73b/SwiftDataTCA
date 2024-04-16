//
//  Feature.swift
//  SwiftDataTCA
//
//  Created by Yeongeun Song on 4/15/24.
//

import Foundation
import ComposableArchitecture
import SwiftData

struct Feature: Reducer {

    struct State: Equatable {
        var items: [Item] = DBManager.shared.fetchItems()
    }

    enum Action: Equatable {
        case plusDBTap
        case minusDBTap
        case undoDBTap
        case redoDBTap
    }

    func reduce(
        into state: inout State,
        action: Action
    ) -> Effect<Action> {
        switch action {
        case .plusDBTap:
            DBManager.shared.appendItem(item: .init(index: state.items.count))
            state.items = DBManager.shared.fetchItems()
            return .none
        case .minusDBTap:
            if let lastItem = DBManager.shared.fetchItems().last {
                DBManager.shared.removeItem(lastItem)
            }
            state.items = DBManager.shared.fetchItems()
            return .none
        case .undoDBTap:
            DBManager.shared.undo()
            state.items = DBManager.shared.fetchItems()
            return .none
        case .redoDBTap:
            DBManager.shared.redo()
            state.items = DBManager.shared.fetchItems()
            return .none
        }
    }
}
