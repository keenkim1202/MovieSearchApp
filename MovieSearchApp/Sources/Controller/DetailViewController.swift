//
//  DetailViewController.swift
//  MovieSearchApp
//
//  Created by KEEN on 2022/04/15.
//

import UIKit

class DetailViewController: BaseViewController {
  
  // MARK: Properties
  let detailView = DetailView()
  var movie: Movie?
  
  // MARK: View Life-Cycle
  override func loadView() {
    self.view = detailView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let movie = movie {
      let infoView = detailView.infoView
      infoView.configure(movie: movie)
      title = infoView.titleLabel.text
    }
    
    navigationController?.navigationBar.prefersLargeTitles = false
    
    if let url = URL(string: "https://www.naver.com/") { // test
      let request = URLRequest(url: url)
      detailView.webView.load(request)
    }
  }
  
}
