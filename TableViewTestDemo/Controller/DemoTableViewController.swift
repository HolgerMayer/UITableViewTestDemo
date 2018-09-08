//
//  DemoTableViewController.swift
//  TableViewTestDemo
//
//  Created by holgermayer on 08.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import UIKit

class DemoTableViewController: UITableViewController {

    var dataSource : ObjectAdapterProtocol? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
     }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let dataSource = self.dataSource else {
            return 0
        }
        
        return dataSource.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataSource = self.dataSource else {
            return 0
        }
        
        return dataSource.numberOfRowsInSection(section: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataSource = self.dataSource else {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "BasicCellID", for: indexPath)
            cell.textLabel?.text = "DataSource not set"
            return cell
        }

        let cellID = dataSource.cellIDFor(section: indexPath.section, row: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)

        // Configure the cell...
        
        let object = dataSource.objectFor(section: indexPath.section, row: indexPath.row)
        
        if object != nil {
            let string = object as? String
            if string != nil {
                cell.textLabel?.text = string
            } else {
                cell.textLabel?.text = "Object is no string"
            }

        } else {
            cell.textLabel?.text = "No object found"
        }
        
         return cell
    }

   

}
