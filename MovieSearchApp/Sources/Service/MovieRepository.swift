//
//  MovieRepository.swift
//  MovieSearchApp
//
//  Created by KEEN on 2022/04/18.
//

import Foundation
import Realm
import RealmSwift

protocol MovieRepositoryType {
  var count: Int { get }
  func add(item: FavoriteMovie)
  func remove(item: FavoriteMovie)
  func fetch() -> [FavoriteMovie]
  func isContain(item: FavoriteMovie) -> Bool
}

final class MovieRepository: MovieRepositoryType {
  private let realm: Realm
  
  init(realm: Realm) {
    self.realm = realm
  }
  
  var count: Int {
    return realm.objects(FavoriteMovie.self).count
  }
  
  func add(item: FavoriteMovie) {
    try! realm.write {
      realm.add(item)
    }
  }
  
  func remove(item: FavoriteMovie) {
    try! realm.write {
      realm.delete(item)
    }
  }
  
  func fetch() -> [FavoriteMovie] {
    return realm.objects(FavoriteMovie.self).map { $0 }
  }
  
  // func isContain(item: Movie) -> Bool {
  //   return realm.objects(Movie.self).filter("_id = \(item._id)").count > 0
  // }
  func isContain(item: FavoriteMovie) -> Bool {
    return realm.objects(FavoriteMovie.self).contains(item) ? true : false
  }
}
