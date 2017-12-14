//
//  SelectRestCell.swift
//  EatWithFriends
//
//  Created by 徐 翰洋 on 12/12/2017.
//  Copyright © 2017 iGuest. All rights reserved.
//

import UIKit

class SelectRestCell: UITableViewCell {

    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var picView: UIImageView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
