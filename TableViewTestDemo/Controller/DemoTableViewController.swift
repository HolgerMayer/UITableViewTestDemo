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
        guard let dataSource = self.dataSource else {
            return
        }
        
        dataSource.registerCells(in: self.tableView)
        self.tableView.accessibilityIdentifier = "ArrayObjectTableView"
     
        navigationItem.rightBarButtonItem = editButtonItem
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
            
            guard let fruitCell = cell as? FruitTableViewCell else {
                let string = object as? String
                if string != nil {
                    cell.textLabel?.text = string
                    cell.accessibilityIdentifier = string
                } else {
                    cell.textLabel?.text = "Object is no string"
                }
                return cell
            }
            
            fruitCell.content = object
 
        } else {
            cell.textLabel?.text = "No object found"
        }
        
         return cell
    }


    override public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let dataSource = self.dataSource else {
            print("Warning : DemoTableViewController datasource not set")
            return nil
        }
        
        let title =  dataSource.sectionTitleFor(section: section)
        
        // Dequeue with the reuse identifier
        let headerID = dataSource.sectionHeaderIDFor(section: section)
        
        let header = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID) as? GroupHeaderView
        header?.delegate = self
        header?.section = section
        header?.headerLabel?.text = title
        header?.accessibilityIdentifier = title
        return header
    }
    
    
    override public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    override public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    
    override public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard let dataSource = self.dataSource else {
            print("Warning : DemoTableViewController datasource not set")
            return
        }
        
        if editingStyle == .delete {
            dataSource.deleteObjectFor(section:indexPath.section , row:indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        /*
        else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
         */
    }
}

extension DemoTableViewController : GroupHeaderViewDelegate {
    func didHitAddAction(_ headerView: GroupHeaderView) {
        
        guard let dataSource = self.dataSource else {
            print("Warning : DemoTableViewController datasource not set")
            return
        }

        let section = headerView.section

        let indexPath = dataSource.addObjectTo(section:section)
        self.tableView.insertRows(at: [indexPath], with: .right)
        
    }
    
    
}
