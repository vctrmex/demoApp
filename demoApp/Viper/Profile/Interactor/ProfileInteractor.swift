//
//  ProfileInteractor.swift
//  demoApp
//
//  Created by VCTR on 02/03/23.
//

import CoreData
import UIKit

class ProfileInteractor: ProfileInteractorInputProtocols {
    var presenter: ProfileInteractorOutputProtocols?
    private var usecase: ApiUseCaseProtocol?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    init(usecase: ApiUseCaseProtocol) {
        self.usecase = usecase
    }
    
    func getFavorites() {
        var movies: [MovieEntity] = []
        let context = self.appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let id = data.value(forKey: "id") as! Int
                let title = data.value(forKey: "title") as! String
                let poster_path = data.value(forKey: "poster_path") as! String
                let movie = MovieEntity(id: id , title: title, poster_path: poster_path)
                movies.append(movie)
            }
            presenter?.setFavorites(data: movies)
        } catch {
            presenter?.setFavorites(data: nil)
        }
    }
}
