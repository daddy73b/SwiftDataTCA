//
//  Item.swift
//  SwiftDataTCA
//
//  Created by 60157085 on 2024/04/12.
//

import Foundation
import SwiftData

@Model
class Item: Identifiable{

    @Attribute(.unique) var id: UUID
    var name: String
    var index: Int

    init(
        id: UUID = UUID(),
        index: Int
    ){
        self.id = id
        self.index = index
        self.name = "item \(index)"
    }
}
