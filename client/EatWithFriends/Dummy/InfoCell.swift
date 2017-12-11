//
//  InfoCell.swift
//  EatWithFriends
//
//  Created by 徐 翰洋 on 09/12/2017.
//  Copyright © 2017 iGuest. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
