//
//  ItemListViewController.swift
//  PotNotes
//
//  Created by James Birtwell on 21/01/2018.
//  Copyright © 2018 James Birtwell. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .blue
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let editItemViewController = EditItemViewController()
        navigationController?.pushViewController(editItemViewController, animated: true)
    }
}
