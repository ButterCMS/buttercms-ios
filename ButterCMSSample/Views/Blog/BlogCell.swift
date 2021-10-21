//
//  BlogCell.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 19.10.2021.
//

import UIKit

class BlogCell: UITableViewCell {
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var shadow: UIView!
    @IBOutlet weak var author: UITextField!
    @IBOutlet weak var title: UITextField!
    @IBOutlet weak var subTitle: UITextField!
    @IBOutlet weak var time: UITextField!
    
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
}
