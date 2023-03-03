//
//  DasboardProtocols.swift
//  demoApp
//
//  Created by VCTR on 02/03/23.
//

import UIKit

protocol DashboardViewProtocol: AnyObject {
    var presenter: DashboardPresenterProtocols?  { get set}
    func setData(_ data: [MovieEntity]?)
    func isFavorite(_ data: DashboardMoviesCollectionViewCell)
    func noFavorite(_ data: DashboardMoviesCollectionViewCell)
}

protocol DashboardPresenterProtocols: AnyObject {
    var router: DashboardRouterProtocols? { get set}
    var view: DashboardViewProtocol? { get set }
    var interactor: DashboardInteractorInputProtocols? { get set}
    func getData()
    func getMoviesCategory(language: LanguageType, type: MovieType)
    func gotoDetail(id: Int,_ controller: UIViewController)
    func updateFavorites(flag: Bool, data: MovieEntity)
    func gotoProfile(_ view: UIViewController)
    func verifyFavorites (_ data: DashboardMoviesCollectionViewCell)
}

protocol DashboardRouterProtocols: AnyObject {
    func createModule() -> UIViewController
    func gotoDetail(id: Int,_ controller: UIViewController)
    func gotoProfile(_ view: UIViewController) 
}

protocol DashboardInteractorOutputProtocols: AnyObject {
    func setData(_ data: [MovieEntity]?)
    func getMoviesCategory(language: LanguageType, type: MovieType)
    func isFavorite(_ data: DashboardMoviesCollectionViewCell)
    func noFavorite(_ data: DashboardMoviesCollectionViewCell)
}

protocol DashboardInteractorInputProtocols: AnyObject {
    var presenter: DashboardInteractorOutputProtocols? { get set }
    func getData()
    func getMoviesCategory(language: LanguageType, type: MovieType)
    func addFavorite(data: MovieEntity)
    func deleteFsvorite(data: MovieEntity)
    func verifyFavorites (_ data: DashboardMoviesCollectionViewCell)
}
