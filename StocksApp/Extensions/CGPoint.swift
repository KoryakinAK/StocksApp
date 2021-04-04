//
//  CGPoint+Plus.swift
//  StocksApp
//
//  Created by Alexey Koryakin on 03.04.2021.
//

import UIKit

extension CGPoint {
    // swiftlint:disable operator_whitespace
    static func +(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x,
                       y: left.y + right.y)
    }
    // swiftlint:enable operator_whitespace
}

extension CGPoint {
    func projectedOffset(decelerationRate: UIScrollView.DecelerationRate) -> CGPoint {
        return CGPoint(x: x.projectedOffset(decelerationRate: decelerationRate),
                       y: y.projectedOffset(decelerationRate: decelerationRate))
    }
}

extension CGFloat { // Velocity value
    func projectedOffset(decelerationRate: UIScrollView.DecelerationRate) -> CGFloat {
        // Magic formula from WWDC
        let multiplier = 1 / (1 - decelerationRate.rawValue) / 1000
        return self * multiplier
    }
}
