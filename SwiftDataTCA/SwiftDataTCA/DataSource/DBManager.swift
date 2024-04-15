//
//  DBManager.swift
//  SwiftDataTCA
//
//  Created by 60157085 on 2024/04/15.
//

import Foundation
import SwiftData

final class DBManager {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = DBManager()

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
            var items = try modelContext.fetch(FetchDescriptor<Item>())
            items.sort { $0.index < $1.index }
            return items
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
