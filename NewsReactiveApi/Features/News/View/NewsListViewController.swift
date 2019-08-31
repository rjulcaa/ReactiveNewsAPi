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
    articlesTableView.dataSource = self
    articlesTableView.delegate = self
    articlesTableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleCell")
    articlesSubscription()
    articlesViewModel.fetchArticles()
  }
  
  private func articlesSubscription(){
    articlesViewModel.loading.bind(to: self.rx.isAnimating).disposed(by: disposbag)
    articlesViewModel.observer
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] data in
        
        self?.articles = data
        self?.articlesTableView.reloadData()
        },onError: { err in
          guard let error = err as? HttpError else{
            print(err.localizedDescription)
            return
          }
          print(error.getValue())
      }).disposed(by: disposbag)
  }

 
}


//Regular implementation
extension NewsListViewController: UITableViewDataSource{
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
    cell.setup(article: articles[indexPath.row])
    return cell
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return articles.count
  }
  
}

extension NewsListViewController:UITableViewDelegate{
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    coordinator?.articleDetail(articleViewModel: articles[indexPath.row])
  }
}
