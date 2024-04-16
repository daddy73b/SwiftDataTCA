//
//  Item.swift
//  GeuniSwiftUI
//
//  Created by 60157085 on 2024/02/27.
//

import Foundation
import SwiftData

@Model
struct Item: Identifiable{

    @Attribute(.unique) var id: UUID
    var name: String

    init(id: UUID = UUID(), name: String){
        self.id = id
        self.name = name
    }
}
