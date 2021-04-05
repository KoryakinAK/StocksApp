//
//  lolPageBuilder.swift
//  StocksApp
//
//  Created by Alexey Koryakin on 05.04.2021.
//

import UIKit

struct StockListBuilder {
    static func buildWithTransition() -> StockListViewController {
        let mainVC = StockListViewController()
        let detailsVC = DetailsViewController()
        let interactor = StockListInteractor()
        let presenter = StockListPresenter()
        let router = StockListRouter()

        mainVC.interactor = interactor
        mainVC.router = router
        mainVC.detailsViewController = detailsVC
        interactor.presenter = presenter
        presenter.viewController = mainVC
        presenter.detailsVC = detailsVC
        router.viewController = mainVC
        router.dataStore = interactor
        // detailsVC.interactor = interactor
        return mainVC
    }
}
