//
//  HomeViewController.swift
//  TamatemPlus
//
//  Created by zaid farouqi on 13/06/2023.
//

import UIKit

class HomeViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    // MARK:  open browser action that inserts the viewcontroller in the navigation controller hierarchy and presenting it
    @IBAction func openBrowser(_ sender: Any) {
        
        let vc:WebViewViewController  = UIStoryboard(storyboard: UIStoryboard.Storyboard.webView).instantiateViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
