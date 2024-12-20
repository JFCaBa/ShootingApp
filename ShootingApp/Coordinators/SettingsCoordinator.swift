//
//  SettingsCoordinator.swift
//  ShootingApp
//
//  Created by Jose on 04/12/2024.
//

import UIKit

final class SettingsCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var parentCoordinator: CoordinatorProtocol?
    var childCoordinators: [CoordinatorProtocol] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = SettingsViewModel()
        viewModel.coordinator = self
        let viewController = SettingsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showHallOfFame() {
        let viewModel = HallOfFameViewModel()
        let viewController = HallOfFameViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
