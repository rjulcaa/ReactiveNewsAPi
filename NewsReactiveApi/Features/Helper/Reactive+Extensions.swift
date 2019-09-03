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

extension UIViewController: BaseViewControllerBehaviorProtocol {}

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
  
  public var errorAppear: Binder<String?>{
    return Binder(self.base, binding: { (vc,value) in
      if let message = value {
        vc.presentAlertController(withMessage: message)
      }
      
    })
  }
  
}


protocol BaseViewControllerBehaviorProtocol{
  func startAnimating()
  func stopAnimating()
  func presentAlertController(withMessage message: String)
}
extension BaseViewControllerBehaviorProtocol where Self : UIViewController {
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
  
  func presentAlertController(withMessage message: String){
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)

    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    
    self.present(alert, animated: true)
  }
}


