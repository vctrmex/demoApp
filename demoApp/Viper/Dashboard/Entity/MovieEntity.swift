//
//  MovieEntity.swift
//  BAZProject
//
//  Created by VCTR on 02/03/23.
//

import Foundation

struct ResponseMovies: Codable {
    let results: [MovieEntity]
}

struct MovieEntity: Codable {
    let id: Int
    let title: String
    let poster_path: String
}

enum LanguageType: String {
    case en = "en"
    case es = "es"
}

enum MovieType: String {
    case trending = "Trending"
    case nowPlaying = "Now Playing"
    case popular = "Popular"
    case topRated = "Top Rated"
    case upcoming = "Upcoming"
    
    var endPoint: String {
        switch self {
            
        case .trending:
            return Endpoints.shared.trending
        case .nowPlaying:
            return Endpoints.shared.nowPlaying
        case .popular:
            return Endpoints.shared.popular
        case .topRated:
            return Endpoints.shared.topRated
        case .upcoming:
            return Endpoints.shared.upcoming
        }
    }
}
