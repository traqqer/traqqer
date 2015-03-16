//
//  Traqqer.swift
//  Traqqer
//
//  Created by John Boggs on 3/11/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import UIKit

class Traqqer {
    class func instantiateStoryboardVC(identifier : String) -> UIViewController {
        return UIStoryboard(
            name: identifier, bundle: nil
        ).instantiateViewControllerWithIdentifier(identifier) as UIViewController
    }

    /*
    Assuming "identifier" is both the nib name and the reuse identifier, registers the nib for the reuse identifier on "tableView"
    */
    class func registerNibAsCell(tableView : UITableView, identifier : String) {
        let nib = UINib(nibName: identifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: identifier)
    }
    
}

