//
//  MainCoordinator.swift
//  NewsReactiveApi
//
//  Created by Richard Julca Amaro on 8/30/19.
//  Copyright © 2019 Richard Julca Amaro. All rights reserved.
//

import UIKit

class MainCoodinator:Coordinator{
  var childCoordinators = [Coordinator]()
  var nagivationController: UINavigationController
  init(navController:UINavigationController) {
    self.nagivationController = navController
  }
  
  func start() {
    let vc = NewsListViewController.instantiateBy(initialStoryboard: .News)
    vc.coordinator = self
    nagivationController.pushViewController(vc, animated: false)
  }
  
  func articleDetail(articleViewModel: ArticleViewModel){
    let vc = ArticleDetailViewController.instantiateBy(initialStoryboard: .News)
    vc.coordinator = self
    vc.articleViewModel = articleViewModel
    nagivationController.pushViewController(vc, animated: true)
  }
  
  func webView(url: String){
    let vc = WebViewController.instantiateBy(initialStoryboard: .News)
    vc.coordinate = self
    vc.url = url
    nagivationController.pushViewController(vc, animated: true)
  }


}

