//
//  ItemCategory.swift
//  PantheonAuctionHouse
//
//  Created by Matthew Cooper on 8/2/17.
//  Copyright © 2017 Matthew Cooper. All rights reserved.
//

import Foundation

class AuctionHouse {
    var weapons : [Weapon] = []
    var armors : [Armor] = []
}

class Weapon {
    var damage : Int = 0
    var name : String = ""
    var price : Int = 0
    var delay : Int = 0
}

class Armor {
    var elementalResistance : Int = 0
    var name : String = ""
    var defense : Int = 0
}

enum CategoryType {
    case Armor, Weapon
}
