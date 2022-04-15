//
//  Endpoint.swift
//  MovieSearchApp
//
//  Created by KEEN on 2022/04/15.
//

import Foundation

enum Endpoint {
  case searchMovie
}

extension URL {
  static let baseURL = "https://openapi.naver.com/v1"
  static func makeEndpoint(_ endpoint: String) -> URL {
    URL(string: baseURL + endpoint)!
  }
}

extension Endpoint {
  var url: URL {
    switch self {
    case .searchMovie:
      return .makeEndpoint("/search/movie.json")
    }
  }
}
