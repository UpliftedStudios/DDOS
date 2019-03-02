//
//  WebVC.swift
//  MyDailyDoseOfCourage
//
//  Created by Raphael M. Hidalgo on 6/12/18.
//  Copyright © 2018 UpliftedStudios. All rights reserved.
//

import UIKit
import WebKit

class WebVC: UIViewController,WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    var webUrl: String = ""
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("The page has loaded.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        let url = URL(string: webUrl)
        let request = URLRequest(url: url!)
        webView.load(request)
        print(request)
    }
}











