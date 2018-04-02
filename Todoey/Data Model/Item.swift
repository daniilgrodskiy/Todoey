//
//  Item.swift
//  Todoey
//
//  Created by Daniil Grodskiy on 4/1/18.
//  Copyright © 2018 Daniil Grodskiy. All rights reserved.
//

import Foundation

class Item: Codable {
    //the ':Encodable' makes it so that the class can be turned into a JSON thing or something
    //for it to be ':Encodable', all the properties must have standard data types (Strings, Booleans, Ints)
    //'Codable' specifies that a particular class conforms to both the 'Encodable' and 'Decodable' protocols
    //Codable = Encodable + Decodable
    
    var title : String = ""
    var done : Bool = false
    
}
