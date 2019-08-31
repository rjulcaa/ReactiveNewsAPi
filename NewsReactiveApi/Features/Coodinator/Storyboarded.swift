//
//  Storyboarded.swift
//  NewsReactiveApi
//
//  Created by Richard Julca Amaro on 8/30/19.
//  Copyright © 2019 Richard Julca Amaro. All rights reserved.
//

import UIKit

protocol Storyboarded {
  static func  instantiateBy(initialStoryboard storyboard: Storyboard) -> Self
}


extension Storyboarded where Self : UIViewController{
  static func instantiateBy(initialStoryboard storyboard: Storyboard) -> Self{
    //Creating the initial ViewController in case we have to deal with
    let id = String(describing: self)
    let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
    return storyboard.instantiateViewController(withIdentifier: id) as! Self
  }
}

enum Storyboard:String{
  case News
  case Main
}
