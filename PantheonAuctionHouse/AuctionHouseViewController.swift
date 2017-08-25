//
//  AuctionHouseViewController.swift
//  PantheonAuctionHouse
//
//  Created by Matthew Cooper on 8/12/17.
//  Copyright © 2017 Matthew Cooper. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import DropDown

class AuctionHouseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var auctionHouse : AuctionHouse?
    var selectedAuctionHouseItem : AuctionHouseItem?
    var filterSelection = Filter.None
    var sortBySelection = SortBy.Alphabet
    var textSearch = ""
    
    @IBOutlet weak var auctionHouseTable: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
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
                
                let filterByName: (AuctionHouseItem) -> Bool = { item in
                    switch(item.item) {
                    case .ArmorEnum(let armor): return self.textSearch != "" ? armor.name.contains(self.textSearch) : true
                    case .WeaponEnum(let weapon): return self.textSearch != "" ? weapon.name.contains(self.textSearch) : true
                    }
                }
                
                
                let sortBy: (AuctionHouseItem, AuctionHouseItem) -> Bool = { item1, item2 in
                    switch(self.sortBySelection) {
                    case .Alphabet: return self.getAuctionHouseItemName(item: item1) < self.getAuctionHouseItemName(item: item2)
                    case .Price: return item1.price < item2.price
                    case .TimeLeft: return item1.expirationDate < item2.expirationDate
                    }
                }
                
                let ahItems = ah.auctionHouseItems
                return ahItems.filter(filterBy).filter(filterByName).sorted(by: sortBy)
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
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        auctionHouseTable.tableHeaderView = searchController.searchBar

        // Do any additional setup after loading the view.
    }
    
    @IBAction func filterButtonPressed(_ sender: UIButton) {
        filterDropDown?.show()
    }
    
    @IBAction func sortButtonPressed(_ sender: UIButton) {
        sortDropDown?.show()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let auctionHouseItem = tableData[indexPath.row]
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        
        
        let placeholderImage = UIImage(named: "Armor")!
        
        let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
            size: CGSize(width: 100, height: 100),
            radius: 20.0
        )
        
        let newPlaceHolder = filter.filter(placeholderImage)
        
        switch(auctionHouseItem.item) {
        case .ArmorEnum(let armor):
            let armorCell = tableView.dequeueReusableCell(withIdentifier: "armorCell") as! ArmorTableViewCell
            armorCell.name.text = armor.name
            armorCell.price.text = String(auctionHouseItem.price)
            armorCell.expiration.text = formatter.string(from: auctionHouseItem.expirationDate)
            armorCell.defense.text = String(armor.defense)
            armorCell.resistance.text = String(armor.elementalResistance)
            
            let url = URL(string: "https://cdn4.iconfinder.com/data/icons/video-game-items-concepts/128/sword-shield-512.png")!
            armorCell.imageView!.af_setImage(withURL: url, placeholderImage: newPlaceHolder, filter: filter)
            return armorCell
        case .WeaponEnum(let weapon):
            let weaponCell = tableView.dequeueReusableCell(withIdentifier: "weaponCell") as! WeaponTableViewCell
            weaponCell.name.text = weapon.name
            weaponCell.price.text = String(auctionHouseItem.price)
            weaponCell.expiration.text = formatter.string(from: auctionHouseItem.expirationDate)
            weaponCell.damage.text = String(weapon.damage)
            weaponCell.delay.text = String(weapon.delay)

            let url = URL(string: "https://cdn1.iconfinder.com/data/icons/outlined-medieval-icons-pack/200/misc_game_coop-512.png")!
            
            weaponCell.imageView!.af_setImage(withURL: url, placeholderImage: newPlaceHolder, filter: filter)
            return weaponCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var segueIdentifier: String
        
        let ahItem = self.tableData[indexPath.row]
        
        selectedAuctionHouseItem = ahItem
        
        switch ahItem.item {
        case .ArmorEnum(_):
            segueIdentifier = "armorIdentifier"
            break
        
        case .WeaponEnum(_):
            segueIdentifier = "weaponIdentifier"
            break
        }
        self.performSegue(withIdentifier: segueIdentifier, sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let selectedItem = selectedAuctionHouseItem {
            switch selectedItem.item {
            case .ArmorEnum(let armor):
                if let armorController = segue.destination as? ArmorViewController {
                    armorController.auctionHouseItem = ArmorAuctionItem(price: selectedItem.price, expirationDate: selectedItem.expirationDate, armor: armor)
                }
                break
            case .WeaponEnum(let weapon):
                if let weaponController = segue.destination as? WeaponViewController {
                    weaponController.auctionHouseItem = WeaponAuctionItem(price: selectedItem.price, expirationDate: selectedItem.expirationDate, weapon: weapon)
                }
                break
            }
        }
    }
}

extension AuctionHouseViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        textSearch = searchController.searchBar.text!
        auctionHouseTable.reloadData()
    }
}

