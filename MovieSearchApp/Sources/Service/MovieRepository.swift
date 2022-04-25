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
  func cleanUp()
}

final class MovieRepository: MovieRepositoryType {
  private let realm: Realm
  
  init(realm: Realm) {
    self.realm = realm
    print(realm.configuration.fileURL ?? "cannot find location")
  }
  
  var count: Int {
    return realm.objects(FavoriteMovie.self).count
  }
  
  func add(item: FavoriteMovie) {
    if let existItem = realm.objects(FavoriteMovie.self).filter("_id == %@", item._id).first {
      try! realm.write {
        existItem.date = Date()
        existItem.isEnable = true
      }
      return
    }

    item.date = Date()
    item.isEnable = true
    
    try! realm.write {
      realm.add(item)
    }
  }
  
  func remove(item: FavoriteMovie) {
    try! realm.write {
      item.isEnable = false
    }
  }
  
  func fetch() -> [FavoriteMovie] {
    return realm.objects(FavoriteMovie.self)
      .filter("isEnable = true")
      .sorted(byKeyPath: "date", ascending: false)
      .map { $0 }
  }
  
  func isContain(item: FavoriteMovie) -> Bool {
    print("item :", item)
    return realm.objects(FavoriteMovie.self).filter("isEnable = true AND _id == %@", item._id).count > 0
  }
  
  func cleanUp() {
    let items = realm.objects(FavoriteMovie.self).filter("isEnable = false")
    try! realm.write {
      realm.delete(items)
    }
  }
}
