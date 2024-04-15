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

    init(id: UUID = UUID(), name: String){
        self.id = id
        self.name = name
    }
}
