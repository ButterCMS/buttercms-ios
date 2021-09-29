//
//  WebViewController.swift
//  ButterCMSSample
//
//  Created by Martin Srb on 26.09.2021.
//

import UIKit
import WebKit

class WebViewControllew: UIViewController, WKUIDelegate {
    var webView: WKWebView!
    var url: String

    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let myURL = URL(string: url)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}

