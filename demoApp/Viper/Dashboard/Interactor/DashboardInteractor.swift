//
//  DashboardInteractor.swift
//  demoApp
//
//  Created by VCTR on 02/03/23.
//

import UIKit
import CoreData

class DashboardInteractor: DashboardInteractorInputProtocols {
    
    var presenter: DashboardInteractorOutputProtocols?
    private var usecase: ApiUseCaseProtocol?
    var response: [MovieEntity]?
    var error: ErrorResponseEntity?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    init(usecase: ApiUseCaseProtocol) {
        self.usecase = usecase
    }
    
    func getData() {
        self.usecase?.getMovie(success: { response in
            self.presenter?.setData(response)
        }, erro: { error in
            self.error = error
        }, completion: {
            self.presenter?.setData(nil)
        } )
    }
    
    func getMoviesCategory(language: LanguageType = .es, type: MovieType) {
        self.usecase?.categoryMovie( category: type.endPoint ?? "", language: language, success: { response in
            if response?.count == 0 {
                self.error = ErrorResponseEntity(code: .errorCustom, message: StaticLabel.noMovies)
            } else {
                self.presenter?.setData(response)
            }
        }, erro: { error in
            self.error = error
        }, completion: {
            self.presenter?.setData(nil)
        })
    }
    
    func addFavorite(data: MovieEntity) {
        let context = self.appDelegate.persistentContainer.viewContext
        let movies = NSEntityDescription.entity(forEntityName: "Favorites", in: context)
        let movie = NSManagedObject(entity: movies!, insertInto: context)
        
        movie.setValue(data.id, forKey: "id")
        movie.setValue(data.title, forKey: "title")
        movie.setValue(data.poster_path, forKey: "poster_path")
        
        do {
          try context.save()
         } catch {
             self.error = ErrorResponseEntity()
        }
        
    }
    
    func deleteFsvorite(data: MovieEntity) {
        let context = self.appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for coredata in result as! [NSManagedObject] {
                let id = coredata.value(forKey: "id") as! Int
                if id == data.id {
                    context.delete(coredata)
                    do {
                        try context.save()
                    }
                    catch {
                        self.error = ErrorResponseEntity()
                    }
                }
            }
        } catch {
            debugPrint(String.errorCustom)
        }
    }
    
    func verifyFavorites(_ data: DashboardMoviesCollectionViewCell) {
        let context = self.appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for coredata in result as! [NSManagedObject] {
                let id = coredata.value(forKey: "id") as! Int
                if id == data.data?.id {
                    self.presenter?.isFavorite(data)
                    break
                } else {
                    self.presenter?.noFavorite(data)
                }
            }
        } catch {
            debugPrint(String.errorCustom)
        }
    }
}
