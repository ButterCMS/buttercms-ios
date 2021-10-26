//
//  PageController.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 25.10.2021.
//

import UIKit
import Combine

class PageViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var pageTitle: UITextView!
    @IBOutlet weak var studyDate: UITextField!
    @IBOutlet weak var industry: UITextField!
    @IBOutlet weak var reviewedBy: UITextField!
    @IBOutlet weak var content: UITextView!

    private var viewModel: PageViewModel!
    private var subscriptions = Set<AnyCancellable>()

    var slug: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PageViewModel()
        self.bind()
        guard let slug = slug else { return }
        viewModel.loadPage(slug: slug)
    }

    override func viewDidLayoutSubviews() {
        self.scrollView.recalculateVerticalContentSize()
    }

    private func bind() {
        subscriptions = [
            viewModel.$title.receive(on: DispatchQueue.main).sink { [weak self] value in self?.pageTitle.text = value },
            viewModel.$studyDate.receive(on: DispatchQueue.main).sink { [weak self] value in self?.studyDate.text = value },
            viewModel.$industry.receive(on: DispatchQueue.main).sink { [weak self] value in self?.industry.text = value },
            viewModel.$reviewedBy.receive(on: DispatchQueue.main).sink { [weak self] value in self?.reviewedBy.text = value },
            viewModel.$content.receive(on: DispatchQueue.main).sink { [weak self] value in self?.content.text = value },
            viewModel.$image.receive(on: DispatchQueue.main).sink { [weak self] value in self?.image.image = value }
        ]
    }

}
