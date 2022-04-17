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
      
      if let url = URL(string: movie.link) { // test
        let request = URLRequest(url: url)
        detailView.webView.load(request)
      }
    }
    
    navigationController?.navigationBar.prefersLargeTitles = false
    

  }
  
}
