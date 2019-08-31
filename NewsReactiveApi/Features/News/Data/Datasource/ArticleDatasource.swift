//
//  ArticleDatasource.swift
//  NewsReactiveApi
//
//  Created by Richard Julca Amaro on 8/28/19.
//  Copyright © 2019 Richard Julca Amaro. All rights reserved.
//

import Foundation
import RxSwift
class ArticleDatasource{
  let httpSession:URLSession
  
  init(httpSession:URLSession = URLSession.shared) {
    self.httpSession = httpSession
  }
  
  func fetchArticles(query:TopHeadLinesQuery) -> Single<[Article]>{
    let client = RestClient()
    return client.performRequest(url: ApiRouter.articles(queryParameter: query), urlSession: httpSession, dataType: ArticlesHeadLines.self)
      .flatMap{ response -> Single<[Article]> in
        return Single.just(response.articles)
    }
    
  }
}
