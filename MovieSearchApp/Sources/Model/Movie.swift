//
//  Movie.swift
//  MovieSearchApp
//
//  Created by KEEN on 2022/04/15.
//

import Foundation
import RealmSwift
import CoreMIDI

class Movie: Decodable {
  var image: String
  var title: String
  var director: String
  var actorList: String
  var userRating: String
  var link: String
  
  enum CodingKeys: String, CodingKey {
    case image, title, director, userRating, link
    case actorList = "actor"
  }
}

struct MovieInfo: Decodable {
  let items: [Movie]
  let total: Int
}

extension Movie {
  func toFavoriteMovie() -> FavoriteMovie {
    return FavoriteMovie(
      title: title,
      link: link,
      image: image,
      director: director,
      actorList: actorList,
      userRating: userRating
    )
  }
}
