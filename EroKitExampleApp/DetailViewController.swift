//
//  DetailViewController.swift
//  EroKitExampleApp
//
//  Created by Evangelos Petousis on 20/6/19.
//  Copyright © 2019 Evangelos Petousis. All rights reserved.
//

import UIKit
import WebKit
import EroKit

class DetailViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            DispatchQueue.main.async {
                let stringURL = "https://www.erowid.org\(detail.detailURL)"
                let url = URL(string: stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
                let req = URLRequest(url: url!)
                self.webView.load(req)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

    var detailItem: Psychoactive? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

