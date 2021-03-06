//
//  String++Extension.swift
//  MovieSearchApp
//
//  Created by KEEN on 2022/04/17.
//

import Foundation

extension String {
  var checkIsEmpty: String {
    if self.isEmpty {
      return "정보 없음"
    } else {
      return self
    }
  }
  
  var checkIsUnRated: String {
    if self == "0.00" {
      return "평점 없음"
    } else {
      return self
    }
  }
}
