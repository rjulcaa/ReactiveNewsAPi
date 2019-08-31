//
//  DataType+Extensions.swift
//  NewsReactiveApi
//
//  Created by Richard Julca Amaro on 8/27/19.
//  Copyright © 2019 Richard Julca Amaro. All rights reserved.
//

import Foundation

extension String {
  func queryFormat() -> String{
    let query = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    return query!
  }
  
  func dateFormat() -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    guard let date = dateFormatter.date(from: self) else {
      return "Error format"
    }
    dateFormatter.dateFormat = "MM/dd/yyyy"
    return dateFormatter.string(from: date)
  }
}
