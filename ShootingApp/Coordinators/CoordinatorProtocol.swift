//
//  CoordinatorProtocol.swift
//  ShootingApp
//
//  Created by Jose on 26/10/2024.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController { get set }
    var parentCoordinator: CoordinatorProtocol? { get set }
    var childCoordinators: [CoordinatorProtocol] { get set }
    func start()
}

extension CoordinatorProtocol {
    func addChildCoordinator(_ coordinator: CoordinatorProtocol) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
