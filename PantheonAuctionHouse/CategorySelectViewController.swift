//
//  FirstViewController.swift
//  PantheonAuctionHouse
//
//  Created by Matthew Cooper on 7/30/17.
//  Copyright © 2017 Matthew Cooper. All rights reserved.
//

import UIKit

class CatageorySelectViewController: UITableViewController {
    
    private var data: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for i in 0...1000 {
            data.append("\(i)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")!
        let text = data[indexPath.row]
        
        cell.textLabel?.text = text
        
        return cell
    }

}

