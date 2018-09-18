//
//  FristTableViewCell.swift
//  Calender
//
//  Created by Simon on 2018/5/27.
//  Copyright © 2018年 Simon. All rights reserved.
//

import UIKit

class FristTableViewCell: UITableViewCell {
//    @IBAction func addTextFeld(_ sender: UITextField) {
//
//        
//    }
    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var useLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
