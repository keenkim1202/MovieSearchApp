//
//  Movie.swift
//  MovieSearchApp
//
//  Created by KEEN on 2022/04/15.
//

import Foundation

struct Movie: Decodable {
  let image: String
  let title: String
  let director: String
  let actorList: String
  let userRating: String
  let link: String
  
  enum CodingKeys: String, CodingKey {
    case image, title, director, userRating, link
    case actorList = "actor"
  }
}

struct MovieInfo: Decodable {
  let items: [Movie]
  let total: Int
}
