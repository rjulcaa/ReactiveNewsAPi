//
//  ApiRouter.swift
//  NewsReactiveApi
//
//  Created by Richard Julca Amaro on 8/28/19.
//  Copyright © 2019 Richard Julca Amaro. All rights reserved.
//

import Foundation

// https://newsapi.org/v2/top-headlines?country=us&apiKey=f9197e331ee2493193a31b43de428eb3 -> To search headlines

//{Error
//  "status": "error",
//  "code": "apiKeyMissing",
//  "message": "Your API key is missing. Append this to the URL with the apiKey param, or use the x-api-key HTTP header."
//}

//https://newsapi.org/v2/top-headlines?country=de&category=business&apiKey=f9197e331ee2493193a31b43de428eb3

//struct ReqBody:Encodable {
//  let q:String
//}


/*En esta clase se define los endpoints, se indica el método, patha parametros y el request que se podría enviar*/

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
    urlRequest.addValue("Bearer f9197e331ee2493193a31b43de428eb3", forHTTPHeaderField: "Authorization")
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

