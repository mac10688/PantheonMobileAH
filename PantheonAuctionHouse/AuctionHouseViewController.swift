//
//  AuctionHouseViewController.swift
//  PantheonAuctionHouse
//
//  Created by Matthew Cooper on 8/12/17.
//  Copyright © 2017 Matthew Cooper. All rights reserved.
//

import UIKit
import Alamofire
import DropDown

class AuctionHouseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    var auctionHouse : AuctionHouse?
    var selectedAuctionHouseItem : AuctionHouseItem?
    var filterSelection = Filter.None
    var sortBySelection = SortBy.Alphabet
    
    @IBOutlet weak var auctionHouseTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filterDropDown: DropDown?
    var sortDropDown: DropDown?
    
    var tableData : [AuctionHouseItem] {
        get {
            if let ah = auctionHouse {
                
                let filterBy: (AuctionHouseItem) -> Bool =  { item in
                    switch(self.filterSelection, item.item) {
                    case (.None, _): return true
                    case (.Armors, .ArmorEnum): return true
                    case (.Weapons, .WeaponEnum): return true
                    default: return false
                    }
                }
                
                let sortBy: (AuctionHouseItem, AuctionHouseItem) -> Bool = { item1, item2 in
                    switch(self.sortBySelection) {
                    case .Alphabet: return self.getAuctionHouseItemName(item: item1) < self.getAuctionHouseItemName(item: item2)
                    case .Price: return item1.price < item2.price
                    case .TimeLeft: return item1.timeLeft < item2.timeLeft
                    }
                }
                
                let ahItems = ah.auctionHouseItems
                return ahItems.filter(filterBy).sorted(by: sortBy)
            } else {
                return []
            }
        }
    }
    
    func getAuctionHouseItemName(item: AuctionHouseItem) -> String {
        switch(item.item) {
        case .ArmorEnum(let armor): return armor.name
        case .WeaponEnum(let weapon): return weapon.name
        }
    }
    
    enum Filter {
        case None, Weapons, Armors
    }
    
    enum SortBy {
        case Alphabet, Price, TimeLeft
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("https://www.dev.pantheonah.com/categories/").responseJSON { response in
            do {
                if let data = response.data,
                    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    print(json)
                    let ah = AuctionHouse(json: json)
                    self.auctionHouse = ah
                    self.auctionHouseTable.reloadData()
                }
            } catch {
                print("Error deserializing JSON: \(error)")
            }
        }
        
        filterDropDown = DropDown()
        
        filterDropDown?.dataSource = ["None", "Armor", "Weapons"]
        
        filterDropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
            switch(index) {
            case 0: self.filterSelection = .None
            case 1: self.filterSelection = .Armors
            case 2: self.filterSelection = .Weapons
            default: self.filterSelection = .None
            }
            self.auctionHouseTable.reloadData()
        }
        
        filterDropDown?.width = 200
        
        sortDropDown = DropDown()
        sortDropDown?.dataSource = ["Alphabet", "Price", "Time Left"]
        
        sortDropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
            switch(index) {
            case 0: self.sortBySelection = .Alphabet
            case 1: self.sortBySelection = .Price
            case 2: self.sortBySelection = .TimeLeft
            default: self.filterSelection = .None
            }
            self.auctionHouseTable.reloadData()
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func filterButtonPressed(_ sender: UIButton) {
        filterDropDown?.show()
    }
    
    @IBAction func sortButtonPressed(_ sender: UIButton) {
        sortDropDown?.show()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        filterDropDown?.show()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let auctionHouseItem = tableData[indexPath.row]
        
        switch(auctionHouseItem.item) {
        case .ArmorEnum(let armor):
            let armorCell = tableView.dequeueReusableCell(withIdentifier: "armorCell") as! ArmorTableViewCell
            armorCell.name.text = armor.name
            armorCell.price.text = String(auctionHouseItem.price)
            armorCell.defense.text = String(armor.defense)
            armorCell.resistance.text = String(armor.elementalResistance)
            armorCell.expiration.text = String(describing: auctionHouseItem.timeLeft)
            return armorCell
        case .WeaponEnum(let weapon):
            let weaponCell = tableView.dequeueReusableCell(withIdentifier: "weaponCell") as! WeaponTableViewCell
            weaponCell.name.text = weapon.name
            weaponCell.price.text = String(auctionHouseItem.price)
            weaponCell.expiration.text = String(describing: auctionHouseItem.timeLeft)
            weaponCell.damage.text = String(weapon.damage)
            weaponCell.delay.text = String(weapon.delay)
            return weaponCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if let ah = auctionHouse {
//            selectedAuctionHouseItem = ah.auctionHouseItems[indexPath.row]
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
