//
//  WebViewController.swift
//  NewsReactiveApi
//
//  Created by Richard Julca Amaro on 8/30/19.
//  Copyright © 2019 Richard Julca Amaro. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, Storyboarded{
  public var url:String?
  public weak var coordinate:MainCoodinator?
  lazy var webKit:WKWebView = WKWebView()
  override func viewDidLoad() {
    view = webKit
    webKit.load(url ?? "")
  }
}



