//
//  AppCoordinator.swift
//  ShootingApp
//
//  Created by Jose on 26/10/2024.
//

// AppCoordinator.swift
import UIKit

final class AppCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var parentCoordinator: CoordinatorProtocol?
    var childCoordinators: [CoordinatorProtocol] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        #if targetEnvironment(simulator)
        showOnboarding()
        #else
        if !UserDefaults.standard.bool(forKey: UserDefaults.Keys.hasSeenOnboarding) {
            showOnboarding()
        } else {
            showHome()
        }
        #endif
    }
    
    private func showOnboarding() {
        let onboardingCoordinator = OnboardingCoordinator(navigationController: navigationController)
        onboardingCoordinator.parentCoordinator = self
        addChildCoordinator(onboardingCoordinator)
        onboardingCoordinator.start()
    }
    
    func showHome() {
        let homeViewModel = HomeViewModel()
        homeViewModel.coordinator = self
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        navigationController.setViewControllers([homeViewController], animated: true)
    }
    
    func showWallet() {
        let walletVC = WalletViewController()
        walletVC.modalPresentationStyle = .pageSheet
        
        if let sheet = walletVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        
        navigationController.present(walletVC, animated: true)
    }
    
    func showAchievements() {
        let viewModel = AchievementsViewModel()
        let achievementsVC = AchievementsViewController(viewModel: viewModel)
        achievementsVC.modalPresentationStyle = .pageSheet
        
        if let sheet = achievementsVC.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        
        navigationController.present(achievementsVC, animated: true)
    }
}
