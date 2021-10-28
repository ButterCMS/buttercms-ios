//
//  CollectionItemCell.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 26.10.2021.
//

import UIKit

class CollectionItemCell: UITableViewCell {

    @IBOutlet weak var shadow: UIView!
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var answer: UITextView!
    @IBOutlet weak var question: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.shadow.layer.cornerRadius = 10
        self.shadow.layer.shadowColor = UIColor.black.cgColor
        self.shadow.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.shadow.layer.shadowRadius = 5
        self.shadow.layer.shadowOpacity = 0.23
        self.content.layer.cornerRadius = 10
        self.content.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
