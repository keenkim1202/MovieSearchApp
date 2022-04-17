//
//  APIService.swift
//  MovieSearchApp
//
//  Created by KEEN on 2022/04/15.
//

import Foundation
import Alamofire

class APIService {
  private let clientID = Bundle.main.clientID
  private let clientSecret = Bundle.main.clientSecret
  
  func fetchLocationInfo(query: String, display: Int, start: Int, result: @escaping (Int, MovieInfo) -> Void) {
    let url = Endpoint.searchMovie.url
    
    let params: Parameters = [
      "query": query,
      "display": display,
      "start": start
    ]
    
    let headers: HTTPHeaders = [
      "X-Naver-Client-Id": clientID,
      "X-Naver-Client-Secret": clientSecret
    ]
    
    AF.request(url, method: .get, parameters: params, headers: headers)
      .validate(statusCode: 200..<500)
      .responseDecodable(of: MovieInfo.self) { response in
        
        switch response.result {
        case .success(let value):
          let code = response.response?.statusCode ?? 500
          result(code, value)
          
        case .failure(let error):
          print("ERROR: \(error.localizedDescription)")
        }
      }
  }
}
