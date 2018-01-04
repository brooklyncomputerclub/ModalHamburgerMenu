//
//  SidePanelPresentationController.swift
//  ModalHamburgerMenu
//
//  Created by Laurence Andersen on 1/3/18.
//

import UIKit

class SidePanelPresentationController: UIPresentationController {
    
    var presentingViewVisibleWidth: CGFloat = 60.0
    
    var isPresenting: Bool = false
    
    override var frameOfPresentedViewInContainerView: CGRect {
        get {
            let bounds = containerView!.bounds
            return CGRect(x: 0.0, y: 0.0, width: bounds.size.width - presentingViewVisibleWidth, height: bounds.size.height)
        }
    }
    
    override var shouldRemovePresentersView: Bool {
        get {
            return false
        }
    }
    
    var presentingViewSuperview: UIView!

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        presentedViewController.modalPresentationStyle = .custom
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        isPresenting = true
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        isPresenting = false
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        
        presentingViewSuperview = nil
    }
}


extension SidePanelPresentationController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self
    }
}


extension SidePanelPresentationController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            animatePresentingTransition(transitionContext)
        } else {
            animateDismissingTransition(transitionContext)
        }
    }
    
    func animatePresentingTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        
        let fromView = fromVC.view!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        presentingViewSuperview = fromView.superview
        
        let containerView = transitionContext.containerView
    
        containerView.addSubview(fromView)
        containerView.addSubview(toView)
        
        let toViewFinalFrame = transitionContext.finalFrame(for: toVC)
        let toViewInitialFrame = CGRect(x: (containerView.bounds.size.width - presentingViewVisibleWidth) * -1, y: 0.0, width: (containerView.bounds.size.width - presentingViewVisibleWidth), height: containerView.bounds.height)

        let duration = transitionDuration(using: transitionContext)
        
        toView.frame = toViewInitialFrame
        
        UIView.animate(withDuration: duration, animations: {
            toView.frame = toViewFinalFrame
            
            var frame = fromView.frame
            frame.origin.x = containerView.frame.maxX - self.presentingViewVisibleWidth
            fromView.frame = frame
        }) { (finished) in
            guard finished == true else {
                return
            }
            
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
    }
    
    func animateDismissingTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!

        let fromView = presentedViewController.view!
        let toView = presentingViewController.view!
        
        var fromViewFinalFrame = transitionContext.finalFrame(for: fromVC)
        fromViewFinalFrame.origin.x = -fromViewFinalFrame.size.width
        
        let toViewFinalFrame = transitionContext.finalFrame(for: toVC)
        
        let transitionDuration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: transitionDuration, animations: {
            fromView.frame = fromViewFinalFrame
            toView.frame = toViewFinalFrame
        }) { (finished) in
            let wasCancelled = transitionContext.transitionWasCancelled
            
            if wasCancelled == false {
                self.presentingViewSuperview.addSubview(toView)
                self.presentingViewSuperview = nil
            }
            
            transitionContext.completeTransition(!wasCancelled)
        }
    }
}
