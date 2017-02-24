//
//  ImageViewController.swift
//  BeeKey
//
//  Created by Влад Бирюков on 23.02.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {


    var icon = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func touchIcon(_ sender: UIButton) {
        icon = sender.currentTitle!
        print(icon)
        let setimage = parent as! AddOrEditTableViewController
        setimage.SetImage(icon)

    }
    
}
