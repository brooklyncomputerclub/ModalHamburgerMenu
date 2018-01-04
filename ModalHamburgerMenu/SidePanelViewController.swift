//
//  SidePanelViewController.swift
//  ModalHamburgerMenu
//
//  Created by Laurence Andersen on 1/3/18.
//

import UIKit

class SidePanelViewController: UIViewController {
    
    @IBAction func chooseMenuOption(_ sender: AnyObject?) {
        guard let button = sender as? UIButton else {
            return
        }
        
        var rootVC: UIViewController? = nil
        
        switch button.tag {
        case 2:
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "viewController2")
        default:
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "viewController1")
        }
        
        guard rootVC != nil, let navController = self.presentingViewController as? UINavigationController else {
            return
        }
        
        navController.viewControllers = [rootVC!]
        
        dismiss(animated: true, completion: nil)
    }

}
