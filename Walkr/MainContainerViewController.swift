//
//  MainContainerViewController.swift
//  Walkr
//
//  Created by Josh Doman on 1/20/17.
//  Copyright © 2017 Josh Doman. All rights reserved.
//

import UIKit

//from WillYou
class MainContainerViewController: UIViewController {
    
    var centerNavigationController: UINavigationController!
    var centerViewController: MapViewController?
    
    var currentState: SlideOutState = .bothCollapsed {
        didSet {
            let shouldShowShadow = currentState != .bothCollapsed
            showShadowForCenterViewController(shouldShowShadow: shouldShowShadow)
        }
    }
    
//    var leftViewController: SettingsSidePanelController? = SettingsSidePanelController()
    var leftViewController: UIViewController? = SettingsSidePanelController()
    
    let centerPanelExpandedOffset: CGFloat = 200
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerViewController = MapViewController()

        centerNavigationController = UINavigationController(rootViewController: centerViewController!)
        
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        
        centerNavigationController.didMove(toParentViewController: self)
        
        view.backgroundColor = .white
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
        
        let when = DispatchTime.now() + 0.2
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.centerViewController?.delegate = self
        }
        
        if let vc = leftViewController as? SettingsSidePanelController, let imageUrl = User.current?.imageUrl {
            vc.profileImageView.loadImageUsingCacheWithUrlString(urlString: imageUrl)
        }
    }
    
    func showShadowForCenterViewController(shouldShowShadow: Bool) {
//        if (shouldShowShadow) {
//            centerNavigationController.view.layer.shadowOpacity = 0.8
//        } else {
//            centerNavigationController.view.layer.shadowOpacity = 0.0
//        }
    }
    
    func addLeftPanelViewController() {
        if (leftViewController == nil) {
            leftViewController = SettingsSidePanelController()
        }
        addChildSidePanelController(sidePanelController: leftViewController!)
    }
    
    func addChildSidePanelController(sidePanelController: UIViewController) {
        view.insertSubview(sidePanelController.view, at: 0)
        
        addChildViewController(sidePanelController)
        sidePanelController.didMove(toParentViewController: self)
    }
}

extension MainContainerViewController: CenterViewControllerDelegate {
    
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .leftPanelExpanded)
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func toggleRightPanel() {
    }
    
    func collapseSidePanels() {
        switch (currentState) {
        case .rightPanelExpanded:
            toggleRightPanel()
        case .leftPanelExpanded:
            toggleLeftPanel()
        default:
            break
        }
    }
    
    func addRightPanelViewController() {
    }
    
    func animateLeftPanel(shouldExpand: Bool) {
        if (shouldExpand) {
            currentState = .leftPanelExpanded
            
            animateCenterPanelXPosition(targetPosition: centerPanelExpandedOffset)
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { finished in
                self.currentState = .bothCollapsed
                
                self.leftViewController!.view.removeFromSuperview()
                self.leftViewController = nil;
            }
        }
    }
    
    func animateRightPanel(shouldExpand: Bool) {
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.centerNavigationController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
}

extension MainContainerViewController: UIGestureRecognizerDelegate {
    // MARK: Gesture recognizer
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        switch(recognizer.state) {
        case .began: break
        case .changed:
            if currentState == .leftPanelExpanded {
                recognizer.view!.center.x = recognizer.view!.center.x + recognizer.translation(in: view).x
                recognizer.setTranslation(CGPoint(x: 0, y: 0), in: view)
            }
        case .ended:
            if (leftViewController != nil) {
                // animate the side panel open or closed based on whether the view has moved more or less than halfway
                let hasMovedGreaterThanHalfway = recognizer.view!.center.x > view.bounds.size.width
                animateLeftPanel(shouldExpand: hasMovedGreaterThanHalfway)
            }
        case .cancelled:
            print("canceled")
        default:
            break
        }
    }
    
}
