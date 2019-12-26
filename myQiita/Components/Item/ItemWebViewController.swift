//
//  ItemWebViewController.swift
//  myQiita-mvvm
//
//  Created by aimon on 2019/12/25.
//  Copyright © 2019 a.naga. All rights reserved.
//

import UIKit
import WebKit

class ItemWebViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView!
    let url: String

    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
