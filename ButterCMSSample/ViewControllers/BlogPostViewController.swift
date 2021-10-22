//
//  BlogPostViewController.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 21.10.2021.
//

import UIKit
import WebKit
import Combine

class BlogPostViewController: UIViewController {
    @IBOutlet weak var time: UITextField!
    @IBOutlet weak var subTitle: UITextField!
    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var author: UITextField!
    @IBOutlet weak var postView: WKWebView!

    private var viewModel: PostViewModel!
    private var subscriptions = Set<AnyCancellable>()

    var slug: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        let js = """
                    document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust='\(250)%'
                 """
        let userScript = WKUserScript(source: js,
                                      injectionTime: .atDocumentEnd,
                                      forMainFrameOnly: true)
        postView.configuration.userContentController.addUserScript(userScript)

        self.viewModel = PostViewModel()
        if let slug = self.slug {
            self.viewModel.loadPost(slug: slug)
        } else {
            self.showErrorAllert(message: "No slug specified")
        }
        bind()
    }

    private func bind() {
        subscriptions = [
            viewModel.$author.receive(on: DispatchQueue.main).sink { [weak self] value in self?.author.text = value },
            viewModel.$title.receive(on: DispatchQueue.main).sink { [weak self] value in self?.postTitle.text = value },
            viewModel.$slug.receive(on: DispatchQueue.main).sink { [weak self] value in self?.subTitle.text = value },
            viewModel.$time.receive(on: DispatchQueue.main).sink { [weak self] value in self?.time.text = value }
        ]
        viewModel.$body.receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.postView.loadHTMLString(value, baseURL: nil)
            }
            .store(in: &subscriptions)
        viewModel.errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                self?.showErrorAllert(message: message)
            }
            .store(in: &subscriptions)
    }
}
