//
//  FavoriteMovie.swift
//  MovieSearchApp
//
//  Created by KEEN on 2022/04/25.
//

import Foundation
import RealmSwift

class FavoriteMovie: Object {
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
  
  convenience init(title: String, link: String, image: String, director: String, actorList: String, userRating: String) {
      self.init()

      self.title = title
      self.link = link
      self.image = image
      self.director = director
      self.actorList = actorList
      self.userRating = userRating
  }
}
