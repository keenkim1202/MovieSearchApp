//
//  Bundle++Extension.swift
//  MovieSearchApp
//
//  Created by KEEN on 2022/04/15.
//

import Foundation

extension Bundle {
  func fetchKey(resourceKey: String, errorText: String) -> String {
    guard let file = self.path(forResource: "APIKEY", ofType: "plist") else { return "" }
    
    guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
    guard let key = resource[resourceKey] as? String else { fatalError(errorText) }
    return key
  }
  
  var clientID: String {
    fetchKey(resourceKey: "ClientID", errorText: "APIKEY.plist에 X-Naver-Client-Id를 설정해주세요.")
  }
  
  var clientSecret: String {
    fetchKey(resourceKey: "ClientSecret", errorText: "APIKEY.plist에 X-Naver-Client-Secret를 설정해주세요.")
  }
}
