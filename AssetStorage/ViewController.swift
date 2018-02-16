//
//  ViewController.swift
//  AssetStorage
//
//  Created by Asit Kumar Mohanty on 16/02/18.
//  Copyright © 2018 Asit Kumar Mohanty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Outlets
    
    @IBOutlet weak var furnitureListTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewElements()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupViewElements()
    {
        furnitureListTableView.isHidden = true
        ViewUtility.addEmptyPage(toView: view, forType: EmptyPageType.NoRecordsFound)
    }
}

