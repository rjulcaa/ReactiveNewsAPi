//
//  Request.swift
//  NewsReactiveApi
//
//  Created by Richard Julca Amaro on 8/28/19.
//  Copyright © 2019 Richard Julca Amaro. All rights reserved.
//

import Foundation

struct TopHeadLinesQuery:Encodable {
  let country:String
}



extension Encodable {
  subscript(key: String) -> Any? {
    return dictionary[key]
  }
  var dictionary: [String: Any] {
    return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
  }
}
