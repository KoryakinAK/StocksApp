//
//  ComplementaryAnimationsController.swift
//  StocksApp
//
//  Created by Alexey Koryakin on 03.04.2021.
//

import UIKit

class PresentationControllerWithAnimations: PresentationController {

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView?.insertSubview(blurView, at: 0)

        performAlongsideTransitionIfPossible { [unowned self] in
            presentingViewController.view.transform = CGAffineTransform(scaleX: 0.76, y: 0.76)
            self.blurView.effect = UIBlurEffect(style: .dark)
        }
    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        blurView.frame = containerView!.frame
    }

    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)

        if !completed {
            self.blurView.removeFromSuperview()
        }
    }

    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()

        performAlongsideTransitionIfPossible { [unowned self] in
            self.presentingViewController.view.transform = .identity
            self.blurView.effect = nil
        }
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)

        if completed {
            self.blurView.removeFromSuperview()
        }
    }

    private func performAlongsideTransitionIfPossible(_ block: @escaping () -> Void) {
        guard let coordinator = self.presentedViewController.transitionCoordinator else {
            block()
            return
        }

        coordinator.animate(alongsideTransition: { (_) in
            block()
        }, completion: nil)
    }

    private lazy var blurView: UIVisualEffectView = {
        let blur = UIVisualEffectView()
        return blur
    }()
}
