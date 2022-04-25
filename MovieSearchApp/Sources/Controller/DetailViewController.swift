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
  var movie: FavoriteMovie?
  
  // MARK: View Life-Cycle
  override func loadView() {
    self.view = detailView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.prefersLargeTitles = false
    
    if let movie = movie {
      let infoView = detailView.infoView
      infoView.configure(movie: movie)
      title = infoView.titleLabel.text
      
      if let url = URL(string: movie.link) {
        let request = URLRequest(url: url)
        detailView.webView.load(request)
      }
    }
  }
  
}
