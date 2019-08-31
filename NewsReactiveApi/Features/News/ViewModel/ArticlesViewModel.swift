//
//  ArticlesViewModel.swift
//  NewsReactiveApi
//
//  Created by Richard Julca Amaro on 8/27/19.
//  Copyright © 2019 Richard Julca Amaro. All rights reserved.
//

import Foundation
import RxSwift
class ArticleListViewModel{
  
  private var articlesObserver = BehaviorSubject<[ArticleViewModel]>(value: [])
  public var loading:PublishSubject<Bool> = PublishSubject()
  public var observer:Observable<[ArticleViewModel]>{
    return articlesObserver.asObservable()
  }
  private let disposeBag = DisposeBag()
  
  public func fetchArticles(){
    loading.onNext(true)
    ArticleDatasource().fetchArticles(query: TopHeadLinesQuery(country: "us"))
      .subscribe(onSuccess: { (articles) in
      self.loading.onNext(false)
      let articlesVM = articles.map{ArticleViewModel(article: $0)}
      self.articlesObserver.onNext(articlesVM)
    }) { (error) in
      self.articlesObserver.onError(error)
    }.disposed(by: disposeBag)
  }
  
}


class ArticleViewModel{
  var article:Article
  init(article:Article){
    self.article = article
  }
}
