//
//  PresentationController.swift
//  StocksApp
//
//  Created by Alexey Koryakin on 03.04.2021.
//

import UIKit

class PresentationController: UIPresentationController {
    override var shouldPresentInFullscreen: Bool {
        return false
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        let bounds = containerView!.bounds
        let heightValue: CGFloat = 540

        return CGRect(x: 0,
                      y: bounds.height - heightValue,
                      width: bounds.width,
                      height: heightValue)
        
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()

        containerView?.addSubview(presentedView!)

    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()

        presentedView?.frame = frameOfPresentedViewInContainerView
    }

    var driver: TransitionDriver!
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)

        if completed {
            driver.direction = .dismiss
        }
    }
}
