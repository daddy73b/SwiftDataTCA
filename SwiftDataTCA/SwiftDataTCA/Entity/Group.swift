//
//  Group.swift
//  SwiftDataTCA
//
//  Created by 60157085 on 2024/04/16.
//

import Foundation
import SwiftData

@Model
class Group {

    @Attribute(.unique) 
    var id: UUID

    @Relationship(deleteRule: .cascade)
    var items: [Item]

    init(
        id: UUID = UUID(),
        items: [Item]
    ){
        self.id = id
        self.items = items
    }
}
