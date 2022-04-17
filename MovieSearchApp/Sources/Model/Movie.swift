//
//  Movie.swift
//  MovieSearchApp
//
//  Created by KEEN on 2022/04/15.
//

import Foundation

struct Movie: Decodable {
  let image: String // image
  let title: String // title
  let director: String // director
  let actorList: String // actor
  let userRating: String // userRating
  let link: String // link
  
  enum CodingKeys: String, CodingKey {
    case image, title, director, userRating, link
    case actorList = "actor"
  }
}

struct MovieInfo: Decodable {
  let items: [Movie]
  let total: Int
}
