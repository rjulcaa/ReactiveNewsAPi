//
//  URLRequest+Extensions.swift
//  NewsReactiveApi
//
//  Created by Richard Julca Amaro on 8/28/19.
//  Copyright © 2019 Richard Julca Amaro. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension URLQueryItem{
  static func transform<T:Encodable>(data: T) -> [URLQueryItem]? {
    return data.dictionary.map{  (key: String, value: Any) -> URLQueryItem in
      let query = URLQueryItem(name: key, value: value as? String)
      return query
    }
  }
}

enum HttpError: Error{
  case ServerError(error:String)
  case dataSerializationError(error:String)
}
extension Error where Self == HttpError{
  func getValue() -> String{
    switch self {
    case .dataSerializationError(error: let errorDescription):
      return errorDescription
    case .ServerError(error: let errorDescripton):
      return errorDescripton
    }
  }
}


