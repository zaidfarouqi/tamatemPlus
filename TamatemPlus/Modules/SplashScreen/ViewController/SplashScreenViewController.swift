//
//  SplashScreenViewController.swift
//  TamatemPlus
//
//  Created by zaid farouqi on 13/06/2023.
//

import UIKit

class SplashScreenViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stratApp()
        
    }
    // MARK: this functions creates a navigation controller an inseting home view controller in the navigation controller hierarchy and presenting it after 3 seconds , the 3 seconds are for showing the app logo 
    func stratApp(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let navigationController = UINavigationController()
            let vc:HomeViewController  = UIStoryboard(storyboard: UIStoryboard.Storyboard.Home).instantiateViewController()
            navigationController.viewControllers = [vc]
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: false)
        }
    }
}
