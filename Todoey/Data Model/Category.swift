//
//  Category.swift
//  Todoey
//
//  Created by Daniil Grodskiy on 4/3/18.
//  Copyright © 2018 Daniil Grodskiy. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
    //each category has a list of items
    //creates a variable 'item's that holds an EMPTY List of type Item
    //defines forward relationship
    //in each Category, there's this thing called items, that'll point to a List of Item objects
    //ONE TO MANY RELATIONSHIP
    
    
    
    
    
//    let array = [1,2,3]
//    let array2 = [Int]() //empty array
//    let array3 : [Int] = [1,2,3]
//    let array4 = Array<Int>() //empty array
//    let array5 : Array<Int> = [1,2,3]
    
    
}
