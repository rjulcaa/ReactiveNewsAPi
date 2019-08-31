//
//  Coordinator.swift
//  NewsReactiveApi
//
//  Created by Richard Julca Amaro on 8/30/19.
//  Copyright © 2019 Richard Julca Amaro. All rights reserved.
//

import UIKit

protocol Coordinator {
  var childCoordinators:[Coordinator] { get set }
  var nagivationController:UINavigationController { get set }
  func start()
}
