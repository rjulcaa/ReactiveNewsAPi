//
//  ArticleDetailViewController.swift
//  NewsReactiveApi
//
//  Created by Richard Julca Amaro on 8/30/19.
//  Copyright © 2019 Richard Julca Amaro. All rights reserved.
//

import UIKit

class ArticleDetailViewController:UIViewController,Storyboarded{
  public weak var coordinator:MainCoodinator?
  public var articleViewModel:ArticleViewModel?
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var urlButton: UIButton!
  @IBOutlet weak var fullDescriptionLabel: UILabel!
  @IBOutlet weak var imageUIImage: UIImageView!
  
  override func viewDidLoad() {
    if let vm = articleViewModel{
      urlButton.setTitle(vm.article.url ?? "Not available", for: .normal)
      fullDescriptionLabel.text = vm.article.content
      imageUIImage.loadImage(fromURL: vm.article.urlToImage ?? "" )
      titleLabel.text = vm.article.title
    }
  }
  
  
  @IBAction func visitWebSiteTap(_ sender: Any) {
    coordinator?.webView(url: (articleViewModel?.article.url)!)
  }
  
}
