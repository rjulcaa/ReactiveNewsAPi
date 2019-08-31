//
//  Reactive+Extensions.swift
//  NewsReactiveApi
//
//  Created by Richard Julca Amaro on 8/29/19.
//  Copyright © 2019 Richard Julca Amaro. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension UIViewController: loadingView {}

extension Reactive where Base: UIViewController {
  
  /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
  public var isAnimating: Binder<Bool> {
    return Binder(self.base, binding: { (vc, active) in
      if active {
        vc.startAnimating()
      } else {
        vc.stopAnimating()
      }
    })
  }
  
}

protocol loadingView{

  func startAnimating()
  func stopAnimating()
}
extension loadingView where Self : UIViewController {
  func startAnimating(){
    let spinner = UIActivityIndicatorView(style: .gray)
    spinner.translatesAutoresizingMaskIntoConstraints = false
    spinner.restorationIdentifier = "spinnerView"
    spinner.startAnimating()
    view.addSubview(spinner)
    spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
  func stopAnimating() {
    for itemView in view.subviews where itemView.restorationIdentifier == "spinnerView"{
      itemView.removeFromSuperview()
    }
  }
}
