//
//  ViewController.swift
//  NewsReactiveApi
//
//  Created by Richard Julca Amaro on 8/26/19.
//  Copyright © 2019 Richard Julca Amaro. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class NewsListViewController: UIViewController,Storyboarded {

  @IBOutlet weak var articlesTableView: UITableView!
  @IBOutlet weak var newsTableView: UITableView!
  var articlesViewModel:ArticleListViewModel = ArticleListViewModel()
  private let disposbag = DisposeBag()
  private var articles:[ArticleViewModel] = []
  
  public weak var coordinator:MainCoodinator?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    articlesTableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleCell")
    setupBinding()
    articlesViewModel.fetchArticles()
  }
  
  private func setupBinding(){
    articlesViewModel.loading.bind(to: self.rx.isAnimating).disposed(by: disposbag)
    articlesViewModel.errorObserver.bind(to: self.rx.errorAppear).disposed(by: disposbag)
    bindTableView()
  }
  
  private func bindTableView(){
    articlesViewModel.observer
      .bind(to: articlesTableView.rx.items(cellIdentifier: "ArticleCell", cellType: ArticleTableViewCell.self)){ row , model , cell in
      cell.setup(article: model)
      }.disposed(by: disposbag)
    
    articlesTableView.rx.modelSelected(ArticleViewModel.self)
      .subscribe(onNext: { [weak self] model in
        self?.coordinator?.articleDetail(articleViewModel: model)
    }).disposed(by: disposbag)
  }

 
}


