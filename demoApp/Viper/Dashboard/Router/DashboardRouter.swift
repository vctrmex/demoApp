//
//  DashboardRouter.swift
//  demoApp
//
//  Created by VCTR on 02/03/23.
//

import UIKit

class DashboardRouter: DashboardRouterProtocols {
    
    func createModule() -> UIViewController {
        guard let view = getStoryboard().instantiateViewController(identifier: "main") as? DashboardViewProtocol else { return UIViewController() }
        let presenter: DashboardPresenterProtocols & DashboardInteractorOutputProtocols = DashboardPresenter()
        let interactor: DashboardInteractorInputProtocols = DashboardInteractor(usecase: ApiUseCase())
        let router: DashboardRouterProtocols = DashboardRouter()
        
        //Conexiones
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        view.presenter = presenter
        
        return view as! UIViewController
    }
    
    func getStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "DashboardStoryboard", bundle: nil)
        return storyboard
    }
    
    func gotoDetail(id: Int,_ controller: UIViewController) {
        let detail = DetailMovieRouter().createModule(id: id)
        controller.navigationController?.pushViewController(detail, animated: true)
    }
    
    func gotoProfile(_ view: UIViewController) {
        view.present(ProfileRouter().createModule(), animated: true)
    }
}
