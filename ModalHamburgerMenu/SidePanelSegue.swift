//
//  SidePanelSegue.swift
//  ModalHamburgerMenu
//
//  Created by Laurence Andersen on 1/3/18.
//

import UIKit

class SidePanelSegue: UIStoryboardSegue {
    internal var sidePanelPresentationController: SidePanelPresentationController!
    
    override init(identifier: String?, source: UIViewController, destination: UIViewController) {
        super.init(identifier: identifier, source: source, destination: destination)
        
        sidePanelPresentationController = SidePanelPresentationController(presentedViewController: destination, presenting: source)
    }
    
    public override func perform() {
        destination.transitioningDelegate = sidePanelPresentationController
        source.present(destination, animated: true, completion: nil)
    }
}
