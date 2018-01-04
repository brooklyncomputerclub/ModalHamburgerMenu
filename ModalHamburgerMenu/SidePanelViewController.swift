//
//  SidePanelViewController.swift
//  ModalHamburgerMenu
//
//  Created by Laurence Andersen on 1/3/18.
//

import UIKit

class SidePanelViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerViewTrailingConstraint: NSLayoutConstraint!
    
    var presenterViewOverlapWidth: CGFloat! = 0.0 {
        didSet {
            updateForPresenterViewOverlapWidth()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
    }
    
    func updateForPresenterViewOverlapWidth() {
        if containerViewTrailingConstraint != nil {
            containerViewTrailingConstraint.isActive = false
            //containerView.removeConstraint(containerViewTrailingConstraint)
            containerViewTrailingConstraint = nil
        }
        
        containerViewTrailingConstraint = containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: presenterViewOverlapWidth * -1)
        containerViewTrailingConstraint.isActive = true
        
    }

}
