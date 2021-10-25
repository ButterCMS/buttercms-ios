//
//  PageCell.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 22.10.2021.
//

import UIKit

class PageCell: UITableViewCell {

    @IBOutlet weak var shadow: UIView!
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var pageImage: UIImageView!
    @IBOutlet weak var title: UITextView!
    @IBOutlet weak var studyDate: UITextField!
    @IBOutlet weak var reviewedBy: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.shadow.layer.cornerRadius = 10
        self.shadow.layer.shadowColor = UIColor.black.cgColor
        self.shadow.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.shadow.layer.shadowRadius = 5
        self.shadow.layer.shadowOpacity = 0.23
        self.content.layer.cornerRadius = 10
        self.content.clipsToBounds = true
    }
}
