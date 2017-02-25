//
//  CustomTableViewCell.swift
//  BeeKey
//
//  Created by Влад Бирюков on 24.01.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var keyImageView: UIImageView!
    @IBOutlet weak var keyNameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
