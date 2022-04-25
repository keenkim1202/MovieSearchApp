//
//  Movie.swift
//  MovieSearchApp
//
//  Created by KEEN on 2022/04/15.
//

import Foundation
import RealmSwift
import CoreMIDI

struct Movie: Decodable {
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
  func toMovie() -> Movie {
    let title = replaceVerticalBarToComma(title)
    let director = replaceVerticalBarToComma(director)
    let actorList = replaceVerticalBarToComma(actorList)

    return Movie(
      image: image,
      title: title,
      director: director,
      actorList: actorList,
      userRating: userRating,
      link: link)
  }
  
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
  
  private func removeTags(_ string: String) -> String {
    return string
      .replacingOccurrences(of: "<b>", with: "")
      .replacingOccurrences(of: "</b>", with: "")
      .replacingOccurrences(of: "|", with: "")
      .replacingOccurrences(of: "&amp;", with: "&")
  }
  
  private func replaceVerticalBarToComma(_ string: String) -> String {
    let array = string.components(separatedBy: "|")
    var string = removeTags(array.joined(separator: ", "))
    
    if string.last == "," || string.last == " " || string.last == "|" {
      string.removeLast()
      
      if string.last == "," {
        string.removeLast()
      }
    }
    
    return string
  }
}
