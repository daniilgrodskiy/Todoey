//
//  Item.swift
//  Todoey
//
//  Created by Daniil Grodskiy on 4/3/18.
//  Copyright © 2018 Daniil Grodskiy. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    //LinkingObjects - defines backwards/linking relationship between Item and Category
    //reverse relationship
    
}
