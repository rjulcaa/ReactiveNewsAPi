//
//  ApiRouter.swift
//  NewsReactiveApi
//
//  Created by Richard Julca Amaro on 8/28/19.
//  Copyright © 2019 Richard Julca Amaro. All rights reserved.
//

import Foundation

enum HTTPMethod:String{
  case GET
  case PUT
  case DELETE
  case POST
  case PATCH
}

enum ApiRouter {
  case articles(queryParameter: TopHeadLinesQuery)
  
  // MARK: - HTTPMethod
  private var method:HTTPMethod {
    switch self {
    case .articles:
      return .GET
    }
    
    
  }
  
  // MARK: - Path
  private var path: String {
    switch self {
    case .articles:
      return "/top-headlines"
    }
  }
  
  // MARK: - Body Parameters
 
  private var queryParamenters:[URLQueryItem]?{
    switch self {
    case .articles(let queries):
      return URLQueryItem.transform(data: queries)
    }
  }
 
  
  // MARK: - URLRequestConvertible
  
  func asURLRequest() throws -> URLRequest  {
    let url =  "https://newsapi.org/v2" + path
    var newUrl = URLComponents(string: url)
    newUrl?.queryItems = self.queryParamenters
    var urlRequest = URLRequest(url: newUrl!.url!)
    urlRequest.httpMethod = method.rawValue
  //urlRequest.addValue("Bearer [Your_API_Key]", forHTTPHeaderField: "Authorization")
    return urlRequest
    
  }
}

enum HTTPHeaderField: String {
  case authentication = "Authorization"
  case contentType = "Content-Type"
  case acceptType = "Accept"
  case acceptEncoding = "Accept-Encoding"
}

enum HTTPStatusCode: Int {
  case ok = 200
  case multipleChoices = 300
  case conflict = 409
  
  static func isSuccess(code: Int) -> Bool {
    return code >= ok.rawValue && code < multipleChoices.rawValue
  }
}

enum ContentType: String {
  case json = "application/json"
}

