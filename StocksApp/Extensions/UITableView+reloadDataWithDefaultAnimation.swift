//
//  UITableView+reloadDataWithDefaultAnimation.swift
//  StocksApp
//
//  Created by Alexey Koryakin on 05.04.2021.
//

import UIKit

// TODO: - Сделать подкласс UITableView для экрана акций и реализовывать это там
extension UITableView {
    func reloadDataWithDefaultAnimation() {
        UIView.transition(with: self, duration: 0.25, options: .transitionCrossDissolve, animations: {
            self.reloadData()
        })
    }
}
