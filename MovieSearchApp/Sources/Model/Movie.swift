//
//  Movie.swift
//  MovieSearchApp
//
//  Created by KEEN on 2022/04/15.
//

import Foundation
import RealmSwift

class Movie: Object, Decodable {
  @Persisted var image: String
  @Persisted var title: String
  @Persisted var director: String
  @Persisted var actorList: String
  @Persisted var userRating: String
  @Persisted var link: String
  
  @Persisted(primaryKey: true) var _id: ObjectId
  
  enum CodingKeys: String, CodingKey {
    case image, title, director, userRating, link
    case actorList = "actor"
  }
}

struct MovieInfo: Decodable {
  let items: [Movie]
  let total: Int
}
