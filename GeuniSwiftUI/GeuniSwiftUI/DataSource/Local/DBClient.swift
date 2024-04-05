//
//  DBClient.swift
//  GeuniSwiftUI
//
//  Created by 60157085 on 2024/02/27.
//

import Foundation
import SwiftData

final class DBClient {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = DBClient()

    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: Item.self)
        self.modelContext = modelContainer.mainContext
        self.modelContext.undoManager = UndoManager()
    }

    func appendItem(item: Item) {
        modelContext.insert(item)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func fetchItems() -> [Item] {
        do {
            return try modelContext.fetch(FetchDescriptor<Item>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func removeItem(_ item: Item) {
        modelContext.delete(item)
    }

    func removeLast() {
        guard let lastItem = fetchItems().last else { return }
        removeItem(lastItem)
    }

    func undo() {
        modelContext.undoManager?.undo()
    }

    func redo() {
        modelContext.undoManager?.redo()
    }
}
