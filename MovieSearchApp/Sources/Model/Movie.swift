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
  let actor: String // actor
  let userRating: String // userRating
  let link: String // link
}

struct MovieInfo: Decodable {
  let items: [Movie]
}
