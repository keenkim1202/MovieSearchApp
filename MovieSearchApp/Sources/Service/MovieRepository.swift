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
  func add(item: Movie)
  func remove(item: Movie)
  func fetch() -> [Movie]
  func isContain(item: Movie) -> Bool
}

final class MovieRepository: MovieRepositoryType {
  private let realm: Realm
  
  init(realm: Realm) {
    self.realm = realm
  }
  
  var count: Int {
    return realm.objects(Movie.self).count
  }
  
  func add(item: Movie) {
    try! realm.write {
      realm.add(item)
    }
  }
  
  func remove(item: Movie) {
    try! realm.write {
      realm.delete(item)
    }
  }
  
  func fetch() -> [Movie] {
    return realm.objects(Movie.self).map { $0 }
  }
  
  func isContain(item: Movie) -> Bool {
    return realm.objects(Movie.self).filter("_id = '\(item._id)'").count > 0
  }
}
