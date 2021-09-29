//
//  HomeSectionCell.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 23.09.2021.
//

import UIKit
import Combine

class HomeSectionCell: UITableViewCell {

    @IBOutlet weak var title: UITextView!
    @IBOutlet weak var subTitle: UITextView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var learnMoreButton: UIButton!
    @IBOutlet weak var content: UIView!

    var url: String = ""
    let buttonClicked = PassthroughSubject<String, Never>()
    let learnButtonClicked = PassthroughSubject<String, Never>()

    @IBAction func urlButtonClicked(_ sender: Any) {
        buttonClicked.send("")
    }

    @IBAction func learnMoreBUttonClicked(_ sender: Any) {
        learnButtonClicked.send(url)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.content.backgroundColor = .clear
        self.content.layer.masksToBounds = false
        self.content.layer.shadowOpacity = 0.23
        self.content.layer.shadowRadius = 5
        self.content.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.content.layer.shadowColor = UIColor.black.cgColor
        self.content.backgroundColor = .white
        self.content.layer.cornerRadius = 10
        self.button.allowTextToScale()
        self.learnMoreButton.allowTextToScale()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
