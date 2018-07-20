//
//  messageCustomCell.swift
//  FriendChat
//
//  Created by Phi Hoang Huy on 7/14/18.
//  Copyright © 2018 Phi Hoang Huy. All rights reserved.
//

import UIKit

class messageCustomCell: UITableViewCell {
    @IBOutlet weak var messageBody: UILabel!
    @IBOutlet weak var senderUserName: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var messageBackGround: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
