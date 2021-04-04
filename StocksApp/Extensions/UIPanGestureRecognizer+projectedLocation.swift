//
//  UIPanGestureRecognizer+projectedLocation.swift
//  StocksApp
//
//  Created by Alexey Koryakin on 04.04.2021.
//

import UIKit

extension UIPanGestureRecognizer {
    func projectedLocation(decelerationRate: UIScrollView.DecelerationRate) -> CGPoint {
        let velocityOffset = velocity(in: view).projectedOffset(decelerationRate: .normal)
        let projectedLocation = location(in: view!) + velocityOffset
        return projectedLocation
    }
}
