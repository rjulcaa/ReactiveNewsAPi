//
//  Article.swift
//  NewsReactiveApi
//
//  Created by Richard Julca Amaro on 8/26/19.
//  Copyright © 2019 Richard Julca Amaro. All rights reserved.
//

import Foundation

struct ArticlesHeadLines:Codable{
  let status:String
  let totalResults:Int
  let articles:[Article]
}
struct Article:Codable{
  let title:String?
  let description:String?
  let source:Source?
  let author:String?
  let url:String?
  let publishedAt:String?
  let content:String?
  let urlToImage:String?
}


struct Source:Codable {
  let name:String?
  
}


