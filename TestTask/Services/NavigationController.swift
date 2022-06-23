//
//  AppCoordinator.swift
//  TestTask
//
//  Created by Artem Astapov on 23.06.2022.
//

import Foundation
import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationController()
    }
    
    private func setupNavigationController() {
        let viewController = MainViewController()
        pushViewController(viewController, animated: true)
    }
}
