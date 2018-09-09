//
//  GroupHeaderView.swift
//  TableViewTestDemo
//
//  Created by holgermayer on 24.08.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import UIKit


public protocol GroupHeaderViewDelegate {
    func didHitAddAction(_ headerView: GroupHeaderView)
}


public class GroupHeaderView: UITableViewHeaderFooterView {

    public var delegate : GroupHeaderViewDelegate?
    
    public var section : Int = 0
    
    @IBOutlet public weak var headerLabel : UILabel!
    
    
    @IBAction public func addAction() {
        
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.didHitAddAction(self)
        
    }
    

}
