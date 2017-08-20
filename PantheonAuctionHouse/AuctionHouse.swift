//
//  ItemCategory.swift
//  PantheonAuctionHouse
//
//  Created by Matthew Cooper on 8/2/17.
//  Copyright © 2017 Matthew Cooper. All rights reserved.
//

import Foundation

class AuctionHouse {
    let auctionHouseItems : [AuctionHouseItem]
    
    init?(json: [String: Any]) {
        guard let auctionHouseItems = json["items"] as? [[String: Any]] else {
            return nil
        }
        
        self.auctionHouseItems = auctionHouseItems.map { item in AuctionHouseItem(json: item)! }
        
    }
    
}

class AuctionHouseItem {
    let price : Int
    let expirationDate : Date
    let item : Item
    
    init(price: Int, expirationDate: Date, item: Item) {
        self.price = price
        self.expirationDate = expirationDate
        self.item = item
    }
    
    convenience init?(json: [String: Any]) {
        guard let price = json["price"] as? Int else {
            return nil
        }
        
        guard let timeLeft = json["expirationDate"] as? Int else {
            return nil
        }
        
        guard let jitem = json["item"] as? [String: Any] else {
            return nil
        }
        
        guard let item = Item(json: jitem) else {
            return nil
        }
        
        let t = Date(timeIntervalSince1970: TimeInterval(timeLeft))
        
        self.init(price: price, expirationDate: t, item: item)
        
    }
    
}

enum Item {
    case ArmorEnum(Armor), WeaponEnum(Weapon)
    
    init?(json: [String: Any]) {
        guard let tag = json["tag"] as? String else {
            return nil
        }
        
        guard let contents = json["contents"] as? [String: Any] else {
            return nil
        }
        
        switch tag {
        case "ArmorItem":
            
            guard let armor = Armor(json: contents) else {
                return nil
            }
            self = .ArmorEnum(armor)
        
        case "WeaponItem":
            guard let weapon = Weapon(json: contents) else {
                return nil
            }
            self = .WeaponEnum(weapon)
        default: return nil
        }
        
    }
}

class Weapon {
    
    init?(json: [String: Any]) {
        guard let damage = json["damage"] as? Int else {
            return nil
        }
        
        guard let name = json["name"] as? String else {
            return nil
        }
        
        guard let delay = json["delay"] as? Int else {
            return nil
        }
        self.damage = damage
        self.name = name
        self.delay = delay
    }
    
    let damage : Int
    let name : String
    let delay : Int
}

class Armor {
    
    init?(json: [String: Any]) {
        guard let elementalResistance = json["elementalResistance"] as? Int else {
            return nil
        }
        
        guard let name = json["name"] as? String else {
            return nil
        }
        
        guard let defense = json["defense"] as? Int else {
            return nil
        }
        
        self.elementalResistance = elementalResistance
        self.name = name
        self.defense = defense
    }
    
    let elementalResistance : Int
    let name : String
    let defense : Int
}
