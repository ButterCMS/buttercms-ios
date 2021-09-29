//
//  HomeTitleCell.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 18.09.2021.
//

import UIKit

class HomeTitleCell: UITableViewCell {

    @IBOutlet weak var headerTitle: UITextView!
    @IBOutlet weak var headerSubTitle: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
